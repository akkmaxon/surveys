require 'rails_helper'

RSpec.describe 'Authentication for User', type: :feature do
  let!(:user) { FactoryGirl.create :user }

  describe 'successfully' do
    it 'login for new user' do
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      within '#messages .alert-success' do
	expect(page).to have_content "Перед началом работы заполните"
      end
      expect(page.current_path).to eq new_info_path
    end

    it 'login for user with filled in info' do
      user = FactoryGirl.create :user
      FactoryGirl.create :info, user: user
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      expect(page.current_path).to eq surveys_path
    end

    it 'logout' do
      FactoryGirl.create :info, user: user
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      click_link "Выход"
      expect(page.current_path).to eq root_path
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
