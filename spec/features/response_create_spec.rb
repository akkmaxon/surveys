require 'rails_helper'

RSpec.describe 'User create new response answering', type: :feature do
  fixtures :questions, :left_statements, :right_statements

  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }

  describe 'impossible for' do
    let(:survey) { Survey.create! user: user }

    after do
      expect(page.current_path).to eq new_user_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit take_survey_path(survey)
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :coordinator
      visit take_survey_path(survey)
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit take_survey_path(survey)
    end
  end

  describe 'when signed in' do
    before do
      sign_in user
      visit root_path
      click_link 'new_survey_link'
    end

    context 'the first questions' do 
      it 'successfully' do
	find('#question_1_answer_3').trigger 'click'
	sleep 1
	user.reload
	expect(user.surveys.first.responses.size).to eq 1
	expect(user.surveys.first.responses.first.answer).to eq "3"
      end
    end

    context 'the second questions' do
      before do
	click_link 'new_survey_link'
	find('#question_1_answer_1').trigger 'click'
	find('#question_29_answer_4').trigger 'click'
	find('#question_30_answer_2').trigger 'click'
      end

      it 'successfully' do
	fill_in 'question_201_answer', with: 'absolutely'
	find('.submit_questions_2').trigger 'click'
	sleep 1
	user.reload
	expect(user.surveys.first.responses.count).to eq 4
	expect(user.surveys.first.responses.find_by(question_number: 1).answer).
	  to eq "1"
	expect(user.surveys.first.responses.find_by(question_number: 29).answer).
	  to eq "4"
	expect(user.surveys.first.responses.find_by(question_number: 30).answer).
	  to eq "2"
	expect(user.surveys.first.responses.find_by(question_number: 201).answer).
	  to eq "absolutely"
      end

      it 'with empty answer' do
	fill_in 'question_201_answer', with: ''
	find('.submit_questions_2').trigger 'click'
	sleep 1
	user.reload
	expect(user.surveys.first.responses.last.answer).to eq ''
      end
    end
  end
end
