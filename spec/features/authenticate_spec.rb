require 'rails_helper'

RSpec.describe 'User must be in a system for visiting', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:survey) { FactoryGirl.create :survey, user: user }

  after do
    expect(page).to have_selector '#messages .alert-danger'
    expect(page.current_path).to eq new_user_session_path
  end

  it 'surveys#index path' do
    visit surveys_path
  end

  it 'surveys#take' do
    visit take_survey_path(survey.id)
  end

  it 'surveys#show' do
    visit survey_path(survey.id)
  end

  it 'info#new' do
    visit new_info_path
  end
end
