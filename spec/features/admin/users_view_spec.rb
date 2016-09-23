require 'rails_helper'

RSpec.describe 'Admin can view all users', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    3.times { FactoryGirl.create :user }
  end

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_admin_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit admin_users_path
    end

    it 'signed in user' do
      sign_in User.first
      visit admin_users_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :coordinator
      visit admin_users_path
    end
  end

  describe 'successfully' do
    before do
      sign_in admin
    end

    it 'page layout' do
      visit admin_users_path
      expect(page).to have_selector '.masonry_container'
      expect(page).to have_selector '.user', count: 3
      expect(page).to have_selector '.active #users_link'
      expect(page).to have_selector 'a#add_user_link'
      expect(page).to have_content "Логин:", count: 3
    end
  end
end
