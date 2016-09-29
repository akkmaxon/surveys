require 'rails_helper'

RSpec.describe 'Working staff take a survey', type: :feature do
  init_data # 3/3 1q and 1/1 2q for management/working_staff
  let!(:survey) { FactoryGirl.create :survey, user: user }
  
  describe 'impossible for' do

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
      info.update work_position: "рабочая должность"
      sign_in user
      visit root_path
      click_link 'new_survey_link'
    end

    it 'data state before' do
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.first.responses).to be_blank
    end

    it 'page layout before' do
      expect(page).to have_selector '#first_questions'
      expect(page).not_to have_selector '#second_questions'
      expect(page).to have_selector '.progress'
      expect(page).to have_selector '.response', count: 1
      expect(page).to have_selector 'input[type="radio"]', count: 5
      expect(page).not_to have_selector '#finish_survey'
      within '.table' do
	%w[1left 1right].each do |title|
	  expect(page).to have_content title
	end
      end
    end

    it 'process first questions' do
      find('#question_1_answer_1').trigger 'click'
      find('#question_28_answer_4').trigger 'click'
      find('#question_29_answer_2').trigger 'click'
      expect(page).not_to have_selector '#first_questions'
      expect(page).to have_selector '#second_questions'
      expect(page).not_to have_selector '#finish_survey'
      user.reload
      expect(user.surveys.first.responses.count).to eq 3
      expect(user.surveys.first.responses.find_by(question_number: 1).answer).
	to eq "1"
      expect(user.surveys.first.responses.find_by(question_number: 28).answer).
	to eq "4"
      expect(user.surveys.first.responses.find_by(question_number: 29).answer).
	to eq "2"
    end

    it 'process second questions' do
      take_a_survey
      expect(page).not_to have_selector '#second_questions'
      expect(page).not_to have_selector '#first_questions'
      expect(page).to have_selector '#finish_survey'
      user.reload
      expect(user.surveys.first.responses.count).to eq 4
      expect(user.surveys.first.responses.last.answer).to eq 'answer sentence'
    end

    it 'and survey is not reliable' do
      find('#question_1_answer_4').trigger 'click'
      find('#question_28_answer_5').trigger 'click'
      find('#question_29_answer_5').trigger 'click'
      fill_in id: 'question_201_answer', with: 'answer sentence'
      find('.submit_questions_2').trigger 'click'
      find('#finish_survey').trigger 'click'
      user.reload
      within '#messages .alert-danger' do
	expect(page).to have_content "С большой долей вероятности можно сказать"
      end
      expect(user.surveys.count).to eq 0
    end

    it 'and survey completed' do
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).not_to be_completed
      take_a_survey
      find('#finish_survey').trigger 'click'
      sleep 1
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).to be_completed
    end

    it 'not completed because one more question is present' do
      question_3 = FactoryGirl.create :question, audience: "Менеджмент", sentence: Faker::Lorem.sentence
      take_a_survey
      expect(page).not_to have_selector('#finish_survey')
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).not_to be_completed
    end
  end
end
