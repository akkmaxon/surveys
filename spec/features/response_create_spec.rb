require 'rails_helper'

RSpec.describe 'User create new response answering', type: :feature do
  init_data

  before do
    login_as user
    visit root_path
    click_link 'new_survey'
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
      click_link 'new_survey'
      find('#question_1_answer_1').trigger 'click'
      find('#question_28_answer_4').trigger 'click'
      find('#question_29_answer_2').trigger 'click'
    end

    it 'successfully' do
      fill_in 'response_answer', with: 'absolutely'
      find('.submit_questions_2').trigger 'click'
      sleep 1
      user.reload
      expect(user.surveys.first.responses.count).to eq 4
      expect(user.surveys.first.responses.find_by(question_number: 1).answer).
	to eq "1"
      expect(user.surveys.first.responses.find_by(question_number: 28).answer).
	to eq "4"
      expect(user.surveys.first.responses.find_by(question_number: 29).answer).
	to eq "2"
      expect(user.surveys.first.responses.find_by(question_number: 201).answer).
	to eq "absolutely"
    end

    it 'with empty answer' do
      fill_in 'response_answer', with: ''
      find('.submit_questions_2').trigger 'click'
      sleep 1
      user.reload
      expect(user.surveys.first.responses.last.answer).to eq ''
    end
  end
end
