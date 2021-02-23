FactoryBot.define do
  factory :schedule do
    schedule_date { '2021-02-23' }
    # 6:00 〜 7:00
    start_time_id { 5 }
    end_time_id { 9 }
    title { '選考課題に取り組む' }
    color_id { 2 }
  end
end
