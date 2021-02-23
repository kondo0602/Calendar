require 'rails_helper'

describe '予定管理機能', type: :system do
  before do
    schedule_a = FactoryBot.create(:schedule)
    visit root_path
  end

  describe '予定新規作成機能' do
    before do
      select '08:00', from: 'schedule[start_time_id]'
      select '09:00', from: 'schedule[end_time_id]'
      fill_in 'schedule[title]', with: '選考課題に取り組む'
    end

    context '全ての項目に値が設定されている場合' do
      before do
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、予定が追加されていること' do
        expect(current_path).to eq root_path
        expect(page).to have_content '選考課題に取り組む'
      end
    end

    context '予定名に値が設定されていない場合' do
      before do
        fill_in 'schedule[title]', with: ''
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '予定名を入力してください'
      end
    end

    context '予定名に21文字以上の文字列が設定されている場合' do
      before do
        fill_in 'schedule[title]', with: 'a' * 21
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '予定名は20文字以内で入力してください'
      end
    end

    context '入力した日付/開始時刻の予定が既に登録されている場合' do
      before do
        select '06:00', from: 'schedule[start_time_id]'
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '日程はすでに存在します'
      end
    end

    context '開始時刻と終了時刻に同じ時刻が設定されている場合' do
      before do
        select '09:00', from: 'schedule[start_time_id]'
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '開始時刻と終了時刻が同じです'
      end
    end

    context '開始時刻に終了時刻より後の時刻が設定されている場合' do
      before do
        select '10:00', from: 'schedule[start_time_id]'
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '開始時刻は終了時刻より前の時刻を指定してください'
      end
    end

    context '開始時刻に他の予定と重複する時刻が設定されている場合' do
      before do
        select '06:30', from: 'schedule[start_time_id]'
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '開始時刻が他の予定と重複しています'
      end
    end

    context '終了時刻に他の予定と重複する時刻が設定されている場合' do
      before do
        select '05:30', from: 'schedule[start_time_id]'
        select '06:30', from: 'schedule[end_time_id]'
        click_on 'カレンダーに追加する'
      end
      it '予定一覧ページに遷移し、適切なメッセージが表示されていること' do
        expect(current_path).to eq schedules_path
        expect(page).to have_content '終了時刻が他の予定と重複しています'
      end
    end
  end
end
