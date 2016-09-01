require 'rails_helper'

RSpec.describe 'Authentication for User', type: :feature do
  let!(:user) { FactoryGirl.create :user }

  describe 'User must be in a system for visiting' do
    let!(:survey) { FactoryGirl.create :survey, user: user }

    after do
      expect(page).to have_selector '#messages .alert-danger'
      expect(page.current_path).to eq new_user_session_path
    end

    it 'surveys#index path' do
      visit surveys_path
    end

    it 'surveys#take' do
      visit take_survey_path(survey.id)
    end

    it 'surveys#show' do
      visit survey_path(survey.id)
    end

    it 'info#new' do
      visit new_info_path
    end
  end
  
  describe 'User can login' do
    it 'successfully' do
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      expect(page).to have_selector '#messages .alert-success'
      expect(page.current_path).to eq new_info_path
    end
  end
end
