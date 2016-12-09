require 'rails_helper'

RSpec.describe 'Coordinator view all surveys', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_surveys_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create(:user)
      visit coordinators_surveys_path
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
      visit coordinators_surveys_path
    end
  end

  describe 'when signed in' do
    it 'redirect after signing in' do
      sign_in coordinator
      visit coordinators_root_path
      expect(page.current_path).to eq coordinators_surveys_path
    end

    it 'successfully' do
      user = FactoryGirl.create(:user, login: 'user123')
      2.times { Survey.create! user: user, completed: true }
      sign_in coordinator
      visit coordinators_surveys_path
      within '.masonry_container' do
	expect(page).to have_selector '.survey', count: 2
	expect(page).to have_selector 'a.show_report', count: 2
      end
    end
  end
end
