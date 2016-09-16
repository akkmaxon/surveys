require 'rails_helper'

RSpec.describe 'Coordinator view all surveys', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  it 'denied access for unsigned user' do
    visit coordinator_surveys_path
    expect(page.current_path).to eq new_coordinator_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'denied access for usual user' do
    sign_in FactoryGirl.create :user
    visit coordinator_surveys_path
    expect(page.current_path).to eq new_coordinator_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'accessing from dashboard' do
    sign_in coordinator
    visit coordinator_root_path
    click_link 'surveys_link'
    expect(page.current_path).to eq coordinator_surveys_path
  end

  it 'successfully' do
    user = FactoryGirl.create :user, login: 'user123'
    FactoryGirl.create :survey, user: user, completed: true
    sign_in coordinator
    visit coordinator_surveys_path
    within '#all_surveys' do
      expect(page).to have_selector '.survey', count: 1
      expect(page).to have_selector '.show_survey', count: 1
      expect(page).to have_content 'user123'
    end
  end
end
