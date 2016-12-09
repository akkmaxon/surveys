require 'rails_helper'

RSpec.describe 'Coordinator can view all the companies', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  before do
    3.times { |n| Company.create! name: "Company#{n}" }
  end

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_companies_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create(:user)
      visit coordinators_companies_path
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
      visit coordinators_companies_path
    end
  end

  describe 'successfully' do
    before do
      sign_in coordinator
    end

    it 'access from the root' do
      visit coordinators_root_path
      click_link 'companies_link'
      expect(page.current_path).to eq coordinators_companies_path
    end

    it 'page layout' do
      visit coordinators_companies_path
      expect(page).to have_selector '.masonry_container'
      expect(page).to have_selector '.active #companies_link'
      expect(page).to have_selector '.company', count: 3
      expect(page).to have_selector 'a.show_report', count: 3
    end
  end
end
