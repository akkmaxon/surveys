require 'rails_helper'

RSpec.describe 'Dashboard page', type: :feature do
  let!(:admin) { FactoryGirl.create :admin }

  context 'require signing in as admin' do
    let(:user) { FactoryGirl.create :user }
    
    it 'unsigned in user cannot view admin dashboard' do
      visit admin_root_path
      expect(page).to have_selector '#messages .alert-danger'
      expect(page.current_path).to eq(new_admin_session_path)
    end

    it 'signed in user cannot view admin dashboard' do
      login_as user
      visit surveys_path
      expect(page.current_path).to eq new_info_path
      visit admin_root_path
      expect(page).to have_selector '#messages .alert-danger'
      expect(page.current_path).to eq(new_admin_session_path)
    end
  end
  
  context 'admin signed in' do
    before do
      visit new_admin_session_path
      fill_in "Логин", with: admin.login
      fill_in "Пароль",with: admin.password
      click_button "Войти"
    end

    it 'good layout' do
      expect(page).to have_content "Вход в систему осуществлен"
      expect(page).to have_content "Панель управления"
    end

    it 'sign out after' do
      click_link "Выход"
      expect(page).to have_content "Выход из системы осуществлен"
    end
  end
end
