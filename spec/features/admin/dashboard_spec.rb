require 'rails_helper'

RSpec.describe 'Dashboard page', type: :feature do
  let!(:admin) { FactoryGirl.create :admin }

  context 'impossible access for' do
    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_admin_session_path)
    end
    
    it 'unsigned in user' do
      visit admin_root_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit admin_root_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :coordinator
      visit admin_root_path
    end
  end
  
  context 'admin signed in' do
    before do
      sign_in admin
      visit admin_root_path
    end

    it 'good layout' do
      expect(page).to have_content "Администратор"
      expect(page).not_to have_content "Самооценка"
      expect(page).not_to have_content "Завершенные опросы"
      expect(page.current_path).to eq admin_users_path
    end
  end
end
