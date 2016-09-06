require 'rails_helper'

RSpec.describe 'Dashboard page', type: :feature do
  let!(:admin) { FactoryGirl.create :admin }

  context 'require signing in as admin' do
    let(:user) { FactoryGirl.create :user }
    
    it 'unsigned in user cannot view admin dashboard' do
      visit admin_root_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_admin_session_path)
    end

    it 'signed in user cannot view admin dashboard' do
      sign_in user
      visit surveys_path
      expect(page.current_path).to eq new_info_path
      visit admin_root_path
      within'#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_admin_session_path)
    end
  end
  
  context 'admin signed in' do
    before do
      sign_in admin
      visit admin_root_path
    end

    it 'good layout' do
      expect(page).to have_content "Панель управления"
      expect(page).not_to have_content "Самооценка"
      expect(page).not_to have_content "Завершенные опросы"
      expect(page.current_path).to eq admin_root_path
    end

    it 'sign out after' do
      click_link "Выход"
      expect(page).to have_content "Выход из системы осуществлен"
    end
  end
end
