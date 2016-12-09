require 'rails_helper'

RSpec.describe 'User create info about himself', type: :feature do
  fixtures :companies

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
      select("топ-менеджер", from: 'info_work_position')
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

    context 'companies not defined by admin' do
      before do
	Company.destroy_all
	visit new_info_path
      end

      it 'page layout' do 
	expect(page).to have_selector '#info_gender'
	expect(page).not_to have_selector '#info_company'
      end

      it 'data from user' do
	select("женский", from: 'info_gender')
	select("более 5 лет", from: 'info_experience')
	select("более 55 лет", from: 'info_age')
	select("третье", from: 'info_workplace_number')
	select("топ-менеджер", from: 'info_work_position')
	click_button "Подтвердить"
	expect(page.current_path).to eq(take_survey_path(user.surveys.first))
	expect(page).to have_selector '.progress'
	user.reload
	expect(user.info.company).to eq "нет ответа"
      end
    end

    context 'only one company' do
      before do
	Company.where('name != ?', 'FirstCompany').destroy_all
	visit new_info_path
      end

      it 'page layout' do
	expect(page).to have_selector '#info_gender'
	expect(page).not_to have_selector '#info_company'
      end

      it 'data from user' do
	select("женский", from: 'info_gender')
	select("более 5 лет", from: 'info_experience')
	select("более 55 лет", from: 'info_age')
	select("третье", from: 'info_workplace_number')
	select("топ-менеджер", from: 'info_work_position')
	click_button "Подтвердить"
	expect(page.current_path).to eq(take_survey_path(user.surveys.first))
	expect(page).to have_selector '.progress'
	user.reload
	user.reload
	expect(user.info.company).to eq('FirstCompany')
      end
    end
  end
end
