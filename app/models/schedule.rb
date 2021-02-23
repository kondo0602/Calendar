class Schedule < ApplicationRecord
  # 各項目が空でないこと
  validates :schedule_date, presence: true
  validates :start_time_id, presence: true
  validates :end_time_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  # 開始時刻と終了時刻が規定の値に収まっていること
  validates_inclusion_of :start_time_id, in: 1..77
  validates_inclusion_of :end_time_id, in: 1..77
  # 同じ日の同じ時間に始まる予定は一つだけであること
  validates :schedule_date, uniqueness: { scope: :start_time_id }
  # 開始時刻と終了時刻が同じでないこと
  validate :start_time_not_equal_end_time?
  # 開始時刻より終了時刻が後の時刻であること
  validate :start_time_before_end_time?
  # 開始時刻が他の予定と重複していないこと
  validate :start_time_included_other_schedules?
  # 終了時刻が他の予定と重複していないこと
  validate :end_time_included_other_schedules?

  def start_time_not_equal_end_time?
    errors.add(:start_time_id, '開始時刻と終了時刻が同じです') if start_time_id == end_time_id
  end

  def start_time_before_end_time?
    errors.add(:start_time_id, '開始時刻は終了時刻より前の時刻を指定してください') if start_time_id > end_time_id
  end

  def start_time_included_other_schedules?
    # 同日の予定全て（登録中の予定を除く）との重複を確認する
    other_schedules = Schedule.where(schedule_date: schedule_date).where.not(id: id)
    other_schedules.each do |other_schedule|
      if start_time_id.to_i.between?(other_schedule.start_time_id,
                                     other_schedule.end_time_id - 1)
        errors.add(:start_time_id, '開始時刻が他の予定と重複しています')
      end
    end
  end

  def end_time_included_other_schedules?
    # 同日の予定全て（登録中の予定を除く）との重複を確認する
    other_schedules = Schedule.where(schedule_date: schedule_date).where.not(id: id)
    other_schedules.each do |other_schedule|
      if end_time_id.to_i.between?(other_schedule.start_time_id + 1,
                                   other_schedule.end_time_id)
        errors.add(:end_time_id, '終了時刻が他の予定と重複しています')
      end
    end
  end
end
