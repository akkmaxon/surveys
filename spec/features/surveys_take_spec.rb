require 'rails_helper'

RSpec.describe 'Work with surveys/take', type: :feature do
  init_data
  
  before do
    login_as user
    visit root_path
    click_link 'new_survey'
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
    expect(page).to have_content question_2.sentence
    expect(page).not_to have_selector '#finish_survey'
    user.reload
    expect(user.surveys.first.responses.count).to eq 3
    expect(user.surveys.first.responses.pluck(:answer)).to eq(%w[1 4 2])
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

  it 'redirect to survey after' do
    take_a_survey
    find('#finish_survey').trigger 'click'
    sleep 1
    user.reload
    expect(page.current_path).to eq survey_path(id: user.surveys.first.id)
    expect(page).to have_selector '.alert-success'
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

  context 'completion of a survey' do
    # user is manager
    it 'completed' do
      take_a_survey
      find('#finish_survey').trigger 'click'
      sleep 1
      click_link 'new_survey'
      user.reload
      expect(user.surveys.count).to eq 2
    end

    it 'completed if present questions for other audience' do
      question_3 = FactoryGirl.create :question, number: 202, audience: 'working_staff', sentence: Faker::Lorem.sentence
      take_a_survey
      find('#finish_survey').trigger 'click'
      sleep 1
      click_link 'new_survey'
      user.reload
      expect(user.surveys.count).to eq 2
    end

    it 'not completed because one more question is present' do
      question_3 = FactoryGirl.create :question, audience: 'management', sentence: Faker::Lorem.sentence
      take_a_survey
      expect(page).not_to have_selector('#finish_survey')
      user.reload
      expect(user.surveys.count).to eq 1
      expect(user.surveys.last).not_to be_completed
    end
  end
end
