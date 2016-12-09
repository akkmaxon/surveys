require 'rails_helper'

RSpec.describe 'Working staff take a survey', type: :feature do
  fixtures :questions, :left_statements, :right_statements

  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { Survey.create! user: user }
  
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
      sign_in FactoryGirl.create(:coordinator)
      visit take_survey_path(survey)
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
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
      expect(page).to have_selector 'input[type="radio"]', count: 6
      expect(page).not_to have_selector '#finish_survey'
      expect(page).not_to have_selector '#show_results_link'
      within '.table' do
	%w[question1_working_staff_left question1_working_staff_right].each do |title|
	  expect(page).to have_content title
	end
      end
      within '.progress-bar' do
	expect(page).to have_content "0/4"
      end
    end

    it 'more questions for working_staff after adding by admin' do
      q = Question.create! opinion_subject: "Я",
	number: 3,
	audience: "Рабочая специальность",
	title: "Title",
	criterion: "Criterion",
	criterion_type: "Вовлеченность"
      LeftStatement.create! title: "Title", text: "Text", question: q
      RightStatement.create! title: "Title", text: "Text", question: q
      Question.create! opinion_subject: "Я",
	number: 202,
	audience: "Рабочая специальность",
	sentence: Faker::Lorem.sentence,
        criterion: "Criterion"
      click_link 'new_survey_link'
      within '.progress-bar' do
	expect(page).to have_content "0/6"
      end
    end

    it 'less questions for working_staff after removing by admin' do
      [1, 201].each do |number|
	Question.find_by(number: number, audience: "Рабочая специальность").destroy
      end
      click_link 'new_survey_link'
      within '.progress-bar' do
	expect(page).to have_content "0/2"
      end
    end

    it 'process first questions' do
      find('#question_1_answer_3').trigger 'click'
      find('#question_29_answer_2').trigger 'click'
      find('#question_30_answer_4').trigger 'click'
      expect(page).not_to have_selector '#first_questions'
      expect(page).to have_selector '#second_questions'
      expect(page).not_to have_selector '#show_results_link'
      user.reload
      expect(user.surveys.first.responses.count).to eq 3
      first = user.surveys.first.responses.find_by(question_number: 1)
      second = user.surveys.first.responses.find_by(question_number: 29)
      third = user.surveys.first.responses.find_by(question_number: 30)
      expect(first.answer).to eq "3"
      expect(first.criterion).
	to eq(questions(:question1_working_staff).criterion)
      expect(first.opinion_subject).
	to eq(questions(:question1_working_staff).opinion_subject)
      expect(second.answer).to eq "2"
      expect(second.criterion).
	to eq(questions(:question29_working_staff).criterion)
      expect(second.opinion_subject).
	to eq(questions(:question29_working_staff).opinion_subject)
      expect(third.answer).to eq "4"
      expect(third.criterion).
	to eq(questions(:question30_working_staff).criterion)
      expect(third.opinion_subject).
	to eq(questions(:question30_working_staff).opinion_subject)
      [first, second, third].each do |resp|
	expect(resp.sentence).to eq ""
      end
    end

    it 'process second questions' do
      take_a_survey
      expect(page).not_to have_selector '#second_questions'
      expect(page).not_to have_selector '#first_questions'
      expect(page).to have_selector '#show_results_link'
      user.reload
      resp = user.surveys.first.responses.last
      expect(user.surveys.first.responses.count).to eq 4
      expect(resp.answer).to eq('answer sentence')
      expect(resp.sentence).
	to eq(questions(:question201_working_staff).sentence)
      expect(resp.criterion).to eq("Свободные ответы")
      expect(resp.criterion_type).to eq("")
    end

    it 'and survey is not reliable' do
      find('#question_1_answer_4').trigger 'click'
      find('#question_29_answer_6').trigger 'click'
      find('#question_30_answer_6').trigger 'click'
      fill_in id: 'question_201_answer', with: 'answer sentence'
      find('.submit_questions_2').trigger 'click'
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
      sleep 1
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).to be_completed
    end

    it 'not completed because one more question is present' do
      Question.create! opinion_subject: "Я",
	audience: "Рабочая специальность",
	number: 203,
	sentence: Faker::Lorem.sentence,
        criterion: "Criterion"
      take_a_survey
      expect(page).not_to have_selector('#show_results_link')
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).not_to be_completed
    end
  end
end
