require 'rails_helper'

RSpec.describe 'Authentication for admin', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:admin) { FactoryGirl.create :admin }

  describe 'successfully' do
    before do
      visit new_admin_session_path
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: admin.password
      click_button "Войти"
    end

    it 'login' do
      expect(page.current_path).to eq admin_users_path
    end

    it 'logout' do
      click_link "Выход"
      expect(page.current_path).to eq root_path
    end
  end

  describe 'unsuccessfully' do
    before do
      visit new_admin_session_path
    end

    after do
      click_button "Войти"
      within '#messages .alert-danger' do
	expect(page).to have_content "Неверный логин или пароль"
      end
    end

    it 'login empty' do
      fill_in "Логин", with: ''
      fill_in "Пароль", with: admin.password
    end

    it 'login wrong' do
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: admin.password
    end
    
    it 'password empty' do
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: ''
    end

    it 'password wrong' do
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: 'wrongpassword'
    end
  end

  describe 'signed in behaviour' do
    it 'redirect to admiin when logged in as admin and user' do
      visit new_admin_session_path
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: admin.password
      click_button "Войти"
      visit new_user_session_path
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: user.password
      click_button "Войти"
      visit root_path
      expect(page.current_path).to eq admin_users_path
    end
  end
end
