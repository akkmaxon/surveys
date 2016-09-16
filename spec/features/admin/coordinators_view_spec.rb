require 'rails_helper'

RSpec.describe 'Admin can view all coordinators', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    3.times { FactoryGirl.create :coordinator }
  end

  describe 'impossible for' do
    before do
      sign_out admin
    end

    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit admin_coordinators_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit admin_coordinators_path
    end

    it 'signed in coordinator' do
      sign_in Coordinator.first
      visit admin_coordinators_path
    end
  end

  describe 'successfully' do
    it 'page layout' do
      visit admin_coordinators_path
      expect(page).to have_selector '#all_coordinators'
      expect(page).to have_selector '.coordinator', count: 3
      expect(page).to have_selector 'a#add_coordinator_link'
      expect(page).to have_content "Логин:", count: 3
    end

    it 'visit from dashboard' do
      visit admin_root_path
      find('#coordinators_link').trigger 'click'
      expect(page.current_path).to eq admin_coordinators_path
    end
  end
end
