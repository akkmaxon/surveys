require 'rails_helper'

RSpec.describe 'User create new response by clicking radio button' do
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
    sleep 1
  end

  it 'successfully' do
    choose id: 'question_1_answer_3'
    click_button 'submit_question_1'
    sleep 1
    user.reload
    expect(user.surveys.first.responses.size).to eq 1
    expect(user.surveys.first.responses.first.answer).to eq "3"
  end

  it 'prevent creating responses on one question' do
    choose id: 'question_1_answer_3'
    click_button 'submit_question_1'
    choose id: 'question_1_answer_1'
    click_button 'submit_question_1'
    sleep 1
    user.reload
    expect(user.surveys.first.responses.count).to eq 1
    expect(user.surveys.first.responses.first.answer).to eq "1"
  end
end
