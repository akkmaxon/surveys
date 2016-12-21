require 'rails_helper'

RSpec.describe 'User create info about himself', type: :feature do
  fixtures :companies, :work_positions

  let(:user) { FactoryGirl.create :user }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_user_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit new_info_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create(:coordinator)
      visit new_info_path
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
      visit new_info_path
    end
  end

  describe 'when signed in' do
    before do
      sign_in user
      visit surveys_path
    end

    it 'check good redirect' do
      expect(page).to have_selector 'form.new_info'
      expect(page).to have_selector '#messages .alert'
      find('#new_survey_link').trigger 'click'
      expect(page).to have_selector 'form.new_info'
    end

    it 'create info with all fields' do
      select("женский", from: 'info_gender')
      select("более 5 лет", from: 'info_experience')
      select("более 55 лет", from: 'info_age')
      select("третье", from: 'info_workplace_number')
      select("ThirdWorkPosition", from: 'info_work_position')
      select("SecondCompany", from: 'info_company')
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Спасибо, теперь Вы можете пройти тест."
      end
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      expect(page).to have_selector '.progress'
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.info).not_to be_nil
    end

    it 'fields filled in automatically' do
      visit new_info_path
      click_button "Подтвердить"
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      user.reload
      expect(user.info).not_to be_nil
    end

    it 'companies not defined by admin' do
      Company.destroy_all
      visit new_info_path

      expect(page).to have_selector '#info_gender'
      expect(page).to have_selector '#info_age'
      expect(page).to have_selector '#info_experience'
      expect(page).to have_selector '#info_workplace_number'
      expect(page).to have_selector '#info_work_position'
      expect(page).not_to have_selector '#info_company'

      select("женский", from: 'info_gender')
      select("более 5 лет", from: 'info_experience')
      select("более 55 лет", from: 'info_age')
      select("третье", from: 'info_workplace_number')
      select("FirstWorkPosition", from: 'info_work_position')
      click_button "Подтвердить"
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      expect(page).to have_selector '.progress'
      user.reload
      expect(user.info.company).to eq "нет ответа"
    end

    it 'one company defined by admin' do
      Company.where('name != ?', 'FirstCompany').destroy_all
      visit new_info_path

      expect(page).to have_selector '#info_gender'
      expect(page).to have_selector '#info_age'
      expect(page).to have_selector '#info_experience'
      expect(page).to have_selector '#info_workplace_number'
      expect(page).to have_selector '#info_work_position'
      expect(page).not_to have_selector '#info_company'

      select("женский", from: 'info_gender')
      select("более 5 лет", from: 'info_experience')
      select("более 55 лет", from: 'info_age')
      select("третье", from: 'info_workplace_number')
      select("FirstWorkPosition", from: 'info_work_position')
      click_button "Подтвердить"
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      expect(page).to have_selector '.progress'
      user.reload
      expect(user.info.company).to eq('FirstCompany')
    end

    it 'work_positions not defined by admin' do
      WorkPosition.destroy_all
      visit new_info_path

      expect(page).to have_selector '#info_gender'
      expect(page).to have_selector '#info_age'
      expect(page).to have_selector '#info_company'
      expect(page).to have_selector '#info_experience'
      expect(page).to have_selector '#info_workplace_number'
      expect(page).not_to have_selector '#info_work_position'

      select("женский", from: 'info_gender')
      select("более 5 лет", from: 'info_experience')
      select("более 55 лет", from: 'info_age')
      select("третье", from: 'info_workplace_number')
      select("FirstCompany", from: 'info_company')
      click_button "Подтвердить"
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      user.reload
      expect(user.info.work_position).to eq("нет ответа")
    end

    it 'one work_position defined by admin' do
      WorkPosition.where('title != ?', 'FirstWorkPosition').destroy_all
      visit new_info_path

      expect(page).to have_selector '#info_gender'
      expect(page).to have_selector '#info_age'
      expect(page).to have_selector '#info_company'
      expect(page).to have_selector '#info_experience'
      expect(page).to have_selector '#info_workplace_number'
      expect(page).not_to have_selector '#info_work_position'

      select("женский", from: 'info_gender')
      select("более 5 лет", from: 'info_experience')
      select("более 55 лет", from: 'info_age')
      select("третье", from: 'info_workplace_number')
      select("FirstCompany", from: 'info_company')
      click_button "Подтвердить"
      expect(page.current_path).to eq(take_survey_path(user.surveys.first))
      user.reload
      expect(user.info.work_position).to eq('FirstWorkPosition')
    end
  end
end
