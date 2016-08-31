require 'rails_helper'

RSpec.describe 'Work with surveys/take', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }

  let!(:question_one) { FactoryGirl.create :question, number: 1 }
  let!(:left_st_for_q_one) { FactoryGirl.create :left_statement, title: '1left', question: question_one }
  let!(:right_st_for_q_one) { FactoryGirl.create :right_statement, title: '1right', question: question_one }

  let!(:question_two) { FactoryGirl.create :question, sentence: Faker::Lorem.sentence }

  let!(:question_28) { FactoryGirl.create :question, number: 28 }
  let!(:left_st_for_q_28) { FactoryGirl.create :left_statement, title: '28left', question: question_28 }
  let!(:right_st_for_q_28) { FactoryGirl.create :right_statement, title: '28right', question: question_28 }

  let!(:question_29) { FactoryGirl.create :question, number: 29 }
  let!(:left_st_for_q_29) { FactoryGirl.create :left_statement, title: '29left', question: question_29 }
  let!(:right_st_for_q_29) { FactoryGirl.create :right_statement, title: '29right', question: question_29 }

  before do
    login_as user
    visit root_path
    click_link 'new_survey'
  end

  it 'Creating new survey' do
    user.reload
    expect(user.surveys).to_not be_blank
    expect(user.surveys.first).to_not be_nil
    expect(user.surveys.first.responses).to be_blank
  end

  it 'Page layout before' do
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

  it 'Survey in action' do
    expect(page).to have_selector '#first_questions'
    expect(page).not_to have_selector '#second_questions'
    find('#question_1_answer_4').trigger 'click'
    find('#question_28_answer_4').trigger 'click'
    find('#question_29_answer_2').trigger 'click'
    expect(page).not_to have_selector '#first_questions'
    expect(page).to have_selector '#second_questions'
    expect(page).to have_content question_two.sentence
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
    expect(page).not_to have_selector '#second_questions'
    user.reload
    expect(user.surveys.first.responses.count).to eq 4
    expect(user.surveys.first.responses.first.answer).to eq '4'
    expect(user.surveys.first.responses.last.answer).to eq 'answer sentence'
  end

  it 'Page layout after' do
    find('#question_1_answer_3').trigger 'click'
    find('#question_28_answer_4').trigger 'click'
    find('#question_29_answer_4').trigger 'click'
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
    expect(page).not_to have_selector '#first_questions'
    expect(page).not_to have_selector '#second_questions'
    expect(page).to have_selector '#finish_survey'
  end 

  it 'Good render and work survey#show after' do
    find('#question_1_answer_3').trigger 'click'
    find('#question_28_answer_4').trigger 'click'
    find('#question_29_answer_4').trigger 'click'
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
    find('#finish_survey').trigger 'click'
    sleep 1
    user.reload
    expect(page.current_path).to eq survey_path(id: user.surveys.first.id)
    expect(page).to have_selector '.alert-success'
    find('#not_agree').trigger 'click'
    expect(page).to have_selector('#email_field .edit_survey')
  end

  it 'Survey completed state is determining properly' do
    question_three = FactoryGirl.create :question, audience: 'working_staff', sentence: Faker::Lorem.sentence
    find('#question_1_answer_3').trigger 'click'
    find('#question_28_answer_4').trigger 'click'
    find('#question_29_answer_4').trigger 'click'
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
    find('#finish_survey').trigger 'click'
    click_link 'new_survey'
    sleep 1
    user.reload
    expect(user.surveys.count).to eq 2
  end

  it 'Survey is not reliable' do
    find('#question_1_answer_4').trigger 'click'
    find('#question_28_answer_5').trigger 'click'
    find('#question_29_answer_5').trigger 'click'
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
    find('#finish_survey').trigger 'click'
    sleep 1
    user.reload
    expect(page).to have_selector '.alert-danger'
    expect(user.surveys.count).to eq 0
  end
end
