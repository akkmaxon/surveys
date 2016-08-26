require 'rails_helper'

RSpec.describe 'Work with surveys/edit', type: :feature do
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

  it 'Creating new survey' do
    user.reload
    expect(user.surveys).to_not be_blank
    expect(user.surveys.first).to_not be_nil
    expect(user.surveys.first.responses).to be_blank
  end

  it 'Page layout before' do
    expect(page).to have_selector '.response', count: 2
    expect(page).to have_selector '.progress'
    expect(page).to have_selector '#finish_survey.disabled'
    within '.table' do
      %w[1left 2left 1right 2right].each do |title|
	expect(page).to have_content title
      end
    end
  end

  it 'Page layout after' do
    choose id: 'question_1_answer_3'
    click_button 'submit_question_1'
    choose id: 'question_2_answer_1'
    click_button 'submit_question_2'
    expect(page).to have_selector '#finish_survey'
    expect(page).to_not have_selector '#finish_survey.disabled'
  end 
end
