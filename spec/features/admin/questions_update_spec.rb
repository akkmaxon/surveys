require 'rails_helper'

RSpec.describe 'Admin can update questions', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:q1) { FactoryGirl.create :question }
  let!(:left_q1) { FactoryGirl.create :left_statement, question: q1 }
  let!(:right_q1) { FactoryGirl.create :right_statement, question: q1 }
  let!(:q2) { FactoryGirl.create :question, sentence: Faker::Lorem.sentence }

  before do
    sign_in admin
    visit admin_questions_path
  end

  describe 'first' do
    before do
      find('#admin_first_questions .edit_question_link').trigger 'click'
    end

    context 'successfully' do
      after do
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос обновлен."
	end
      end

      it 'changing one thing' do
	fill_in 'field_1q_criterion', with: 'New Criterion'
	click_button 'submit_1q'
	expect(page).to have_content 'New Criterion'
      end

      it 'changing nothing' do
	click_button 'submit_1q'
      end

      it 'changing all properties' do
	fill_in 'field_1q_number', with: 123
	find('#field_1q_audience_2').trigger 'click'
	fill_in 'field_1q_left_title', with: 'New Left Title'
	fill_in 'field_1q_left_text', with: 'New Left Text'
	fill_in 'field_1q_right_title', with: 'New Right Title'
	fill_in 'field_1q_right_text', with: 'New Right Text'
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: 'New Criterion'
	click_button 'submit_1q'
	within '#admin_first_questions' do
	  expect(page).to have_content '123'
	  expect(page).to have_content "Рабочая специальность"
	  expect(page).to have_content 'New Left Title'
	  expect(page).to have_content 'New Left Text'
	  expect(page).to have_content 'New Right Title'
	  expect(page).to have_content 'New Right Text'
	  expect(page).to have_content "Я"
	  expect(page).to have_content 'New Criterion'
	end
      end
    end

    context 'unsuccessfully' do
      after do
	expect(page).not_to have_content 'New'
	expect(page).not_to have_selector '#messages .alert-success'
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
	click_button 'submit_1q'
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
	click_button 'submit_1q'
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
	click_button 'submit_1q'
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
	click_button 'submit_1q'
      end
    end
  end

  describe 'second' do
    before do
      find('#admin_second_questions .edit_question_link').trigger 'click'
    end

    context 'successfully' do
      after do
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос обновлен."
	end
      end

      it 'changing nothing' do
	click_button 'submit_2q'
      end

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
	expect(page).not_to have_selector '#messages .alert-success'
	expect(page).to have_selector '.container_question_form'
      end
    end
  end
end
