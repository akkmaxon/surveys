require 'rails_helper'

RSpec.describe 'Authentication for coordinator', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:coordinator) { FactoryGirl.create :coordinator }

  describe 'successfully' do
    before do
      visit new_coordinator_session_path
      fill_in "Логин", with: coordinator.login
      fill_in "Пароль", with: coordinator.password
      click_button "Войти"
    end

    it 'login' do
      expect(page.current_path).to eq coordinators_surveys_path
    end

    it 'logout' do
      click_link "Выход"
      expect(page.current_path).to eq root_path
    end
  end

  describe 'unsuccessfully' do
    before do
      visit new_coordinator_session_path
    end

    after do
      click_button "Войти"
      within '#messages .alert-danger' do
	expect(page).to have_content "Неверный логин или пароль"
      end
    end

    it 'login empty' do
      fill_in "Логин", with: ''
      fill_in "Пароль", with: coordinator.password
    end

    it 'login wrong' do
      fill_in "Логин", with: user.login
      fill_in "Пароль", with: coordinator.password
    end
    
    it 'password empty' do
      fill_in "Логин", with: coordinator.login
      fill_in "Пароль", with: ''
    end

    it 'password wrong' do
      fill_in "Логин", with: coordinator.login
      fill_in "Пароль", with: 'wrongpassword'
    end
  end
end
