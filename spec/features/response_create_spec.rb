require 'rails_helper'

RSpec.describe 'User create new response answering', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }

  let!(:question_one) { FactoryGirl.create :question }
  let!(:left_st_for_q_one) { FactoryGirl.create :left_statement, title: '1left', question: question_one }
  let!(:right_st_for_q_one) { FactoryGirl.create :right_statement, title: '1right', question: question_one }
  let!(:question_two) { FactoryGirl.create :question }
  let!(:left_st_for_q_two) { FactoryGirl.create :left_statement, title: '2left', question: question_two }
  let!(:right_st_for_q_two) { FactoryGirl.create :right_statement, title: '2right', question: question_two }

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
      question_two.update! sentence: Faker::Lorem.sentence
      click_link 'new_survey'
      find('#question_1_answer_1').trigger 'click'
    end

    it 'successfully' do
      fill_in 'response_answer', with: 'absolutely'
      find('.submit_questions_2').trigger 'click'
      sleep 1
      user.reload
      expect(user.surveys.first.responses.count).to eq 2
      expect(user.surveys.first.responses.last.answer).to eq 'absolutely'
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
