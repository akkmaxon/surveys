require 'rails_helper'

RSpec.describe 'User create new response by clicking radio button', type: :feature do
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

  it 'successfully' do
    find('#question_1_answer_3').trigger 'click'
    sleep 1
    user.reload
    expect(user.surveys.first.responses.size).to eq 1
    expect(user.surveys.first.responses.first.answer).to eq "3"
  end

  it 'check for disappearing tr' do
    expect(page).to have_selector '.new_response', count: 2
    find('#question_1_answer_5').trigger 'click'
    sleep 1
    user.reload
    expect(page).to_not have_selector '#submit_question_1'
    expect(page).to have_selector '.new_response', count: 1
    expect(user.surveys.first.responses.count).to eq 1
    expect(user.surveys.first.responses.first.answer).to eq "5"
  end
end
