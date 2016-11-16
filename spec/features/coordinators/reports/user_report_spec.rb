require 'rails_helper'

RSpec.describe 'Coordinator view report for one user', type: :feature do
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
      visit coordinators_reports_path(survey: survey.to_param)
    end

    it 'signed in user' do
      sign_in user
      visit coordinators_reports_path(survey: survey.to_param)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinators_reports_path(survey: survey.to_param)
    end
  end
    
  describe 'when signed in' do
    before do
      sign_in coordinator
      visit coordinators_reports_path(survey: survey.to_param)
    end

    it 'page layout' do
      expect(page).to have_selector '#coordinator_survey'
    end

    it 'access from coordinators/surveys' do
      visit coordinators_surveys_path
      find('.show_survey').trigger 'click'
      expect(page.current_path).to eq coordinators_reports_path
    end

    it 'rescue when survey is wrong' do
      visit coordinators_reports_path(survey: "abcdefg")
      expect(page).to have_selector('#messages .alert-danger')
      expect(page.current_path).to eq coordinators_surveys_path
    end
  end
end
