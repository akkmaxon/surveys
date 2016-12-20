require 'rails_helper'

RSpec.describe 'Admin can update questions', type: :feature do
  fixtures :questions, :left_statements, :right_statements

  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admins_questions_path
  end

  describe 'first' do
    before do
      first('#admin_first_questions .edit_question_link').trigger 'click'
    end

    it 'changing all properties' do
      q1 = questions(:question1_management)
      fill_in 'field_1q_title', with: 'What are you doing?'
      fill_in 'field_1q_number', with: 123
      find('#field_1q_audience_2').trigger 'click'
      fill_in 'field_1q_left_title', with: 'New Left Title'
      fill_in 'field_1q_left_text', with: 'New Left Text'
      fill_in 'field_1q_right_title', with: 'New Right Title'
      fill_in 'field_1q_right_text', with: 'New Right Text'
      find('#field_1q_subject_1').trigger 'click'
      fill_in 'field_1q_criterion', with: 'New Criterion'
      find('#field_1q_criterion_type_1').trigger 'click'
      click_button 'submit_1q'
      sleep 1
      q1.reload
      expect(q1.title).to eq('What are you doing?')
      expect(q1.number).to eq(123)
      expect(q1.audience).to eq("Рабочая специальность")
      expect(q1.left_statement.title).to eq('New Left Title')
      expect(q1.right_statement.title).to eq('New Right Title')
      expect(q1.left_statement.text).to eq('New Left Text')
      expect(q1.right_statement.text).to eq('New Right Text')
      expect(q1.opinion_subject).to eq("Я")
      expect(q1.criterion).to eq('New Criterion')
      expect(q1.criterion_type).to eq("Вовлеченность")
    end

    context 'unsuccessfully' do
      after do
	expect(page).not_to have_content 'New'
	click_button 'submit_1q'
      end

      it 'with empty number' do
	fill_in 'field_1q_number', with: ''
	find('#field_1q_audience_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'New Left Title'
	fill_in 'field_1q_left_text', with: 'New Left Text'
	fill_in 'field_1q_right_title', with: 'New Right Title'
	fill_in 'field_1q_right_text', with: 'New Right Text'
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: 'New Criterion'
      end

      it 'with empty criterion' do
	fill_in 'field_1q_number', with: 123
	find('#field_1q_audience_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'New Left Title'
	fill_in 'field_1q_left_text', with: 'New Left Text'
	fill_in 'field_1q_right_title', with: 'New Right Title'
	fill_in 'field_1q_right_text', with: 'New Right Text'
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: ''
      end

      it 'with empty left text' do
	fill_in 'field_1q_number', with: 123
	find('#field_1q_audience_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'New Left Title'
	fill_in 'field_1q_left_text', with: ''
	fill_in 'field_1q_right_title', with: 'New Right Title'
	fill_in 'field_1q_right_text', with: 'New Right Text'
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: 'New Criterion'
	find('#field_1q_criterion_type_1').trigger 'click'
      end

      it 'with empty right text' do
	fill_in 'field_1q_number', with: 123
	find('#field_1q_audience_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'New Left Title'
	fill_in 'field_1q_left_text', with: 'New Left Text'
	fill_in 'field_1q_right_title', with: 'New Right Title'
	fill_in 'field_1q_right_text', with: ''
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: 'New Criterion'
	find('#field_1q_criterion_type_1').trigger 'click'
      end
    end
  end

  describe 'second' do
    before do
      first('#admin_second_questions .edit_question_link').trigger 'click'
    end

    context 'successfully' do
      it 'changing all' do
	find('#field_2q_audience_2').trigger 'click'
	fill_in 'field_2q_sentence', with: 'New Sentence'
	click_button 'submit_2q'
	within '#admin_second_questions' do
	  expect(page).to have_content "Рабочая специальность"
	  expect(page).to have_content "New Sentence"
	end
      end
    end

    context 'unsuccessfully' do
      it 'with empty sentence' do
	fill_in 'field_2q_sentence', with: ''
	click_button 'submit_2q'
	expect(page).to have_selector '.container_question_form'
      end
    end
  end
end
