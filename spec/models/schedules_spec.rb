require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    @schedule = build(:schedule)
  end

  describe 'バリデーション' do
    it '全ての項目に値が設定されている場合、正常になること' do
      expect(@schedule.valid?).to eq(true)
    end

    it '日付が空の場合、エラーとなること' do
      @schedule.schedule_date = ''
      expect(@schedule.valid?).to eq(false)
    end

    it '予定名が空の場合、エラーとなること' do
      @schedule.title = ''
      expect(@schedule.valid?).to eq(false)
    end

    it '予定名が20文字より長い場合、エラーとなること' do
      @schedule.title = 'a' * 21
      expect(@schedule.valid?).to eq(false)
    end

    it '開始時刻が定められた範囲の値でない場合、エラーとなること' do
      # id = 1(05:00) 〜 id = 77(24:00)の間の値であること
      @schedule.start_time_id = 0
      expect(@schedule.valid?).to eq(false)
    end

    it '終了時刻が定められた範囲の値でない場合、エラーとなること' do
      # id = 1(05:00) 〜 id = 77(24:00)の間の値であること
      @schedule.end_time_id = 78
      expect(@schedule.valid?).to eq(false)
    end

    it '日付と開始時刻が同じ場合、エラーとなること' do
      @schedule.save
      duplicate_schedule = @schedule.dup
      expect(duplicate_schedule.valid?).to eq(false)
    end

    it '開始時刻と終了時刻が同じ場合、エラーとなること' do
      @schedule.start_time_id = 1
      @schedule.end_time_id = 1
      expect(@schedule.valid?).to eq(false)
    end

    it '開始時刻が終了時刻より後の場合、エラーとなること' do
      @schedule.start_time_id = 2
      @schedule.end_time_id = 1
      expect(@schedule.valid?).to eq(false)
    end

    it '開始時刻が他の予定と重複している場合、エラーとなること' do
      @schedule.save
      duplicate_schedule = @schedule.dup
      duplicate_schedule.start_time_id = 6
      duplicate_schedule.end_time_id = 10
      expect(duplicate_schedule.valid?).to eq(false)
    end

    it '終了時刻が他の予定と重複している場合、エラーとなること' do
      @schedule.save
      duplicate_schedule = @schedule.dup
      duplicate_schedule.start_time_id = 2
      duplicate_schedule.end_time_id = 6
      expect(duplicate_schedule.valid?).to eq(false)
    end
  end
end
