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
    it 'good layout' do
      visit new_admin_session_path
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: admin.password
      click_button "Войти"
      visit admin_root_path
      expect(page).not_to have_selector 'header'
      expect(page).to have_selector 'aside'
      expect(page).to have_selector 'section'
    end
  end
end
