require 'rails_helper'

RSpec.describe "Coordinator can view user's surveys", type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:s1) { FactoryGirl.create :survey, user: user, completed: true }
  let!(:s2) { FactoryGirl.create :survey, user: user, completed: true }
  let(:coordinator) { FactoryGirl.create :coordinator }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_user_surveys_path(user)
    end

    it 'signed in user' do
      sign_in user
      visit coordinators_user_surveys_path(user)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinators_user_surveys_path(user)
    end
  end

  describe 'when signed in' do
    before do
      sign_in coordinator
      visit coordinators_user_surveys_path(user)
    end

    it 'page layout' do
      expect(page).to have_selector '.survey a.show_survey', count: 2
    end

    it 'access from users path' do
      visit coordinators_users_path
      find('.user .show_surveys').trigger 'click'
      expect(page.current_path).to eq coordinators_user_surveys_path(user)
      expect(page).to have_selector '.survey', count: 2
    end
  end
end
