require 'rails_helper'

RSpec.describe 'Coordinator visit dashboard page', type: :feature do
  let!(:coordinator) { FactoryGirl.create :coordinator }

  context 'impossible for' do
    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему."
      end
      expect(page.current_path).to eq(new_coordinator_session_path)
    end

    it 'unsigned in user' do
      visit coordinator_root_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit coordinator_root_path
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinator_root_path
    end
  end
  
  context 'successfully' do
    before do
      sign_in coordinator
      visit coordinator_root_path
    end

    it 'page layout' do
      within 'header' do
	expect(page).to have_content "Координатор"
	expect(page).to have_content "Опросы"
	expect(page).not_to have_content "Самооценка"
	expect(page).not_to have_content "Завершенные опросы"
      end
      expect(page.current_path).to eq coordinator_surveys_path
    end
  end
end
