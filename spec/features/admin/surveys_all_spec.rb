require 'rails_helper'

RSpec.describe 'Admin view all surveys', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  it 'denied access for unsigned user' do
    visit admin_surveys_path
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'denied access for usual user' do
    sign_in FactoryGirl.create :user
    visit admin_surveys_path
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'successfully' do
    user = FactoryGirl.create :user, login: 'user123'
    FactoryGirl.create :survey, user: user, completed: true
    sign_in admin
    visit admin_surveys_path
    within '#all_surveys' do
      expect(page).to have_selector '.survey', count: 1
      expect(page).to have_selector '.show_survey', count: 1
      expect(page).to have_content 'user123'
    end
  end
end
