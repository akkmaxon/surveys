require 'rails_helper'

RSpec.describe 'Coordinator visit dashboard page', type: :feature do
  let!(:coordinator) { FactoryGirl.create :coordinator }

  context 'impossible for' do
    it 'unsigned in user' do
      visit coordinator_root_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_coordinator_session_path)
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit coordinator_root_path
      within'#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_coordinator_session_path)
    end
  end
  
  context 'successfully' do
    before do
      sign_in coordinator
      visit coordinator_root_path
    end

    it 'page layout' do
      within 'header' do
	expect(page).to have_content "Панель управления"
	expect(page).to have_content "Опросы"
	expect(page).not_to have_content "Самооценка"
	expect(page).not_to have_content "Завершенные опросы"
      end
      expect(page.current_path).to eq coordinator_root_path
    end

    it 'sign out after' do
      click_link "Выход"
      expect(page).to have_content "Выход из системы осуществлен"
    end
  end
end