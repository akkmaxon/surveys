require 'rails_helper'

RSpec.describe 'Admin can delete questions', type: :feature do
  fixtures :questions, :left_statements, :right_statements

  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admins_questions_path
  end

  it 'successfully first question' do
    visit admins_questions_path
    expect(Question.all_first_questions.count).to eq 6
    first('#admin_first_questions .delete_question').trigger 'click'
    within '#messages .alert-success' do
      expect(page).to have_content "Вопрос удален."
    end
    expect(Question.all_first_questions.count).to eq 5
  end

  it 'successfully second question' do
    visit admins_questions_path
    expect(Question.all_second_questions.count).to eq 2
    first('#admin_second_questions .delete_question').trigger 'click'
    within '#messages .alert-success' do
      expect(page).to have_content "Вопрос удален."
    end
    expect(Question.all_second_questions.count).to eq 1
  end
end
