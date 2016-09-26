require 'rails_helper'

RSpec.describe 'Coordinator can view all users', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  before do
    3.times { FactoryGirl.create :user }
  end

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinator_users_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit coordinator_users_path
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinator_users_path
    end
  end

  describe 'successfully' do
    before do
      sign_in coordinator
    end

    it 'access from dashboard' do
      visit coordinator_root_path
      click_link 'users_link'
      expect(page.current_path).to eq coordinator_users_path
    end

    it 'page layout' do
      visit coordinator_users_path
      expect(page).to have_selector '.masonry_container'
      expect(page).to have_selector '.active #users_link'
      expect(page).to have_selector '.user', count: 3
      expect(page).to have_selector 'a.show_surveys', count: 3
    end
  end
end
