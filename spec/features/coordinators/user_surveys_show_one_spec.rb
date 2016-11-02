require 'rails_helper'

RSpec.describe 'Coordinator can view full information about survey', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { FactoryGirl.create :survey, user: user, completed: true }
  let!(:response1) { FactoryGirl.create :response, survey: survey }
  let!(:response2) { FactoryGirl.create :response, survey: survey }
  let(:coordinator) { FactoryGirl.create :coordinator }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_user_survey_path(user, survey)
    end

    it 'signed in user' do
      sign_in user
      visit coordinators_user_survey_path(user, survey)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinators_user_survey_path(user, survey)
    end
  end
    
  describe 'when signed in' do
    before do
      sign_in coordinator
      visit coordinators_user_survey_path(user, survey)
    end

    it 'page layout' do
      expect(page).to have_selector '#coordinator_survey'
    end

    it 'access from coordinators/surveys' do
      visit coordinators_surveys_path
      find('.show_survey').trigger 'click'
      expect(page.current_path).to eq coordinators_user_survey_path(user, survey)
    end

    it 'access from coordinators/user/surveys' do
      visit coordinators_user_surveys_path(user)
      find('.show_survey').trigger 'click'
      expect(page.current_path).to eq coordinators_user_survey_path(user, survey)
    end
  end
end
