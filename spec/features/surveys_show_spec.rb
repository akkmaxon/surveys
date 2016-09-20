require 'rails_helper'

RSpec.describe 'Work with surveys/show', type: :feature do
  context 'User load surveys/show manually' do
    let(:user) { FactoryGirl.create :user }
    let!(:info) { FactoryGirl.create :info, user: user }
    let!(:survey) { FactoryGirl.create :survey, user: user }

    describe 'impossible for' do
      after do
	expect(page.current_path).to eq new_user_session_path
	within '#messages .alert-danger' do
	  expect(page).to have_content "Войдите, пожалуйста, в систему"
	end
      end

      it 'unsigned in user' do
	visit survey_path(survey)
      end

      it 'coordinator' do
	sign_in FactoryGirl.create :coordinator
	visit survey_path(survey)
      end

      it 'admin' do
	sign_in FactoryGirl.create :admin
	visit survey_path(survey)
      end
    end

    describe 'when user is signed in' do
      before do
	sign_in user
	visit survey_path(survey)
      end

      it 'Page layout is ok' do
	expect(page).to have_selector('.header')
	expect(page).to have_selector('.table')
	expect(page).to have_selector('.charts')
	expect(page).to have_selector('#email_field')
	within('#agreement') do
	  expect(page).to have_selector("input[type='radio']", count: 3)
	end
      end

      it 'agreement & email are absent' do
	survey.reload
	expect(survey.user_agreement).to eq ''
	expect(survey.user_email).to eq nil
      end

      it 'User click agreement' do
	find('#not_agree').trigger 'click'
	sleep 1
	survey.reload
	expect(survey.user_agreement).to eq 'я не согласен со своим результатом'
	expect(page).to have_selector('#email_field')
      end

      it 'User fill in an email form' do
	find('#not_agree').trigger 'click'
	sleep 1
	fill_in id: 'survey_user_email', with: 'my@email.com'
	click_button 'leave_email'
	expect(page.current_path).to eq surveys_path
	survey.reload
	expect(survey.user_email).to eq('my@email.com')
      end

      it 'Attempt to watch survey of other user' do
	other_user = FactoryGirl.create :user
	forbidden_survey = FactoryGirl.create :survey, user: other_user
	visit "/surveys/#{forbidden_survey.id}"
	within '#messages .alert-danger' do
	  expect(page).to have_content "Вы не можете видеть результаты других пользователей"
	end
	expect(page.current_path).to eq surveys_path
      end

      it 'Try to watch non-existent survey' do
	number_of_survey = 1000000
	visit "/surveys/#{number_of_survey}"
	within '#messages .alert-danger' do
	  expect(page).to have_content "Опрос №#{number_of_survey} не существует"
	end
	expect(page.current_path).to eq surveys_path
      end
    end
  end
end
