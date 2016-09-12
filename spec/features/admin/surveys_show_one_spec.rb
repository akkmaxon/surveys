require 'rails_helper'

RSpec.describe 'Admin can view full information about survey', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let(:user) { FactoryGirl.create :user }
  let!(:survey) { FactoryGirl.create :survey, user: user, completed: true }
  let!(:response1) { FactoryGirl.create :response, survey: survey }
  let!(:response2) { FactoryGirl.create :response, survey: survey }

  before do
    sign_in admin
    visit admin_survey_path(survey)
  end

  it 'impossible for unsigned in user' do
    sign_out admin
    visit admin_survey_path(survey)
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'impossible for signed in usual user' do
    sign_out admin
    sign_in user
    visit admin_survey_path(survey)
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end
    
  it 'page layout' do
    within '#survey' do
      expect(page).to have_selector 'table'
    end
  end

  it 'access from admin/surveys' do
    visit admin_surveys_path
    find('.show_survey').trigger 'click'
    expect(page.current_path).to eq admin_survey_path(survey)
  end
end
