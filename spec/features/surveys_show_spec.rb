require 'rails_helper'

RSpec.describe 'Work with surveys/show', type: :feature do
  context 'User load surveys/show manually' do
    let(:user) { FactoryGirl.create :user }
    let!(:info) { FactoryGirl.create :info, user: user }
    let!(:survey) { FactoryGirl.create :survey, user: user }

    before do
      login_as user
      visit "/surveys/#{survey.id}"
    end

    it 'Page layout is ok' do
      expect(page).to have_selector('.header')
      expect(page).to have_selector('.table')
      within('#agreement') do
	expect(page).to have_selector("input[type='radio']", count: 3)
      end
    end

    it 'User click agreement' do
      expect(survey.user_agreement).to eq ''
      find('#not_agree').trigger 'click'
      sleep 1
      survey.reload
      expect(survey.user_agreement).to eq 'я не согласен со своим результатом'
    end

    it 'User fill in an email form' do
      expect(survey.user_email).to eq nil
      find('#not_agree').trigger 'click'
      sleep 1
      fill_in id: 'survey_user_email', with: 'my@email.com'
      click_button 'leave_email'
      expect(page.current_path).to eq surveys_path
      survey.reload
      expect(survey.user_email).to eq 'my@email.com'
    end
  end
end
