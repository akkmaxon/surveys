require 'rails_helper'

RSpec.describe 'Coordinator can view full information about survey', type: :feature do
  let(:user) { FactoryGirl.create :user }
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
      visit coordinator_user_survey_path(user, survey)
    end

    it 'signed in user' do
      sign_in user
      visit coordinator_user_survey_path(user, survey)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinator_user_survey_path(user, survey)
    end
  end
    
  describe 'when signed in' do
    before do
      sign_in coordinator
      visit coordinator_user_survey_path(user, survey)
    end

    it 'page layout' do
      within '#survey' do
	expect(page).to have_selector 'table'
      end
    end

    it 'access from coordinator/surveys' do
      visit coordinator_surveys_path
      find('.show_survey').trigger 'click'
      expect(page.current_path).to eq coordinator_user_survey_path(user, survey)
    end

    it 'access from coordinator/user/surveys' do
      visit coordinator_user_surveys_path(user)
      find('.show_survey').trigger 'click'
      expect(page.current_path).to eq coordinator_user_survey_path(user, survey)
    end
  end
end
