require 'rails_helper'

RSpec.describe 'User view taken surveys', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:s1) { FactoryGirl.create :survey, user: user, completed: true }
  let!(:s2) { FactoryGirl.create :survey, user: user, completed: true }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_user_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned user' do
      visit surveys_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :coordinator
      visit surveys_path
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit surveys_path
    end
  end

  describe 'when signed in' do
    it 'as other user' do
      other_user = FactoryGirl.create :user
      FactoryGirl.create :info, user: other_user
      sign_in other_user
      visit surveys_path
      expect(page).not_to have_selector '.survey'
    end

    it 'page layout' do
      sign_in user
      visit surveys_path
      expect(page).to have_selector '.survey', count: 2
      expect(page).to have_selector '.survey a.show_report', count: 2
    end
  end
end

