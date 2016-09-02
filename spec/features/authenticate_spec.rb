require 'rails_helper'

RSpec.describe 'Authentication for User', type: :feature do
  let!(:user) { FactoryGirl.create :user }

  describe 'User must be in a system for visiting' do
    let!(:survey) { FactoryGirl.create :survey, user: user }

    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
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
  
  describe 'successfully' do
    it 'with good properties' do
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      within '#messages .alert-success' do
	expect(page).to have_content "Перед началом работы заполните"
      end
      expect(page.current_path).to eq new_info_path
    end
  end

  describe 'unsuccessfully' do
    before do
      visit new_user_session_path
    end

    after do
      click_button "Войти"
      within '#messages .alert-danger' do
	expect(page).to have_content "Неверный логин или пароль"
      end
    end

    it 'login empty' do
      fill_in "Логин", with: ''
      fill_in "Пароль", with: user.password
    end

    it 'login wrong' do
      fill_in "Логин", with: 'wronglogin'
      fill_in "Пароль", with: user.password
    end
    
    it 'password empty' do
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: ''
    end

    it 'password wrong' do
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: 'wrongpassword'
    end
  end
end
