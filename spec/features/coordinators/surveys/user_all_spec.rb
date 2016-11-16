require 'rails_helper'

RSpec.describe "Coordinator view all user's surveys", type: :feature do
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
      visit coordinators_surveys_path(user: user.login)
    end

    it 'signed in user' do
      sign_in user
      visit coordinators_surveys_path(user: user.login)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinators_surveys_path(user: user.login)
    end
  end

  describe 'when signed in' do
    before do
      sign_in coordinator
      visit coordinators_surveys_path(user: user.login)
    end

    it 'page layout' do
      expect(page).to have_selector '.survey a.show_survey', count: 2
    end

    it 'rescue when login is wrong' do
      visit coordinators_surveys_path
      visit coordinators_surveys_path(user: "#{user.login}abc")
      expect(page).to have_selector('#messages .alert-danger')
      expect(page.current_path).to eq coordinators_surveys_path
    end

    it 'access from users path' do
    # visit coordinators_users_path
    # click_link class: 'show_surveys'
    # expect(page.current_path).to eq coordinators_surveys_path(user: user.login)
    end
  end
end
