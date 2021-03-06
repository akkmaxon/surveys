require 'rails_helper'

RSpec.describe 'Work with surveys/show', type: :feature do
  context 'User load surveys/show manually' do
    let(:user) { FactoryGirl.create :user }
    let!(:info) { FactoryGirl.create :info, user: user }
    let!(:survey) { Survey.create! user: user, completed: true }

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
	expect(page).to have_selector('#email_field')
	within('#agreement') do
	  expect(page).to have_selector("input[type='radio']", count: 3)
	end
      end

      it 'agreement & email are absent' do
	survey.reload
	expect(survey.user_agreement).to eq '-'
	expect(survey.user_email).to eq '-'
      end

      it 'User click agreement' do
	find('#not_agree').trigger 'click'
	sleep 1
	survey.reload
	expect(survey.user_agreement).to eq 'я не согласен со своим результатом'
	expect(page.current_path).to eq survey_path(survey)
	expect(page).to have_selector 'table'
	expect(page).not_to have_selector('#agreement')
	visit survey_path(survey)
	find('#agree').trigger 'click'
	sleep 1
	survey.reload
	expect(survey.user_agreement).to eq 'я полностью согласен со своим результатом'
      end

      it 'User fill in an email form' do
	fill_in id: 'survey_user_email', with: 'my@email.com'
	click_button 'leave_email'
	sleep 1
	survey.reload
	expect(survey.user_email).to eq('my@email.com')
	expect(page.current_path).to eq survey_path(survey)
	expect(page).to have_selector 'table'
	expect(page).not_to have_selector('#email_field')
	visit survey_path(survey)
	fill_in id: 'survey_user_email', with: 'other@email.com'
	click_button 'leave_email'
	sleep 1
	survey.reload
	expect(survey.user_email).to eq('other@email.com')
      end

      it 'Attempt to watch survey of other user' do
	other_user = FactoryGirl.create(:user)
	forbidden_survey = Survey.create!(user: other_user, completed: true)
	visit "/surveys/#{(forbidden_survey.id + CRYPT_SURVEY).to_s(36)}"
	within '#messages .alert-danger' do
	  expect(page).to have_content "Вы не можете видеть результаты других пользователей"
	end
	expect(page.current_path).to eq surveys_path
      end

      it 'Try to watch non-existent survey' do
	number_of_survey = 1000000
	visit "/surveys/#{number_of_survey}"
	within '#messages .alert-danger' do
	  expect(page).to have_content "Опрос #{number_of_survey} не существует"
	end
	expect(page.current_path).to eq surveys_path
      end
    end
  end
end
