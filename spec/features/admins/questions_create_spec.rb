require 'rails_helper'

RSpec.describe 'Admin can create questions', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admins_questions_path
    find('#add_question .dropdown-toggle').trigger 'click'
  end

  describe 'first' do
    before do
      find('#add_first_question').trigger 'click'
    end

    context 'successfully' do
      it 'with all properties' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in 'field_1q_number', with: 123
	find('#field_1q_audience_1').trigger 'click'
	find('#field_1q_subject_1').trigger 'click'
	fill_in 'field_1q_criterion', with: 'Something New'
	find('#field_1q_criterion_type_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'Left Title'
	fill_in 'field_1q_left_text', with: 'Text from left'
	fill_in 'field_1q_right_title', with: 'Right Title'
	fill_in 'field_1q_right_text', with: 'Text from right'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).to have_content 'I want to ask you'
	  expect(page).to have_content '123'
	  expect(page).to have_content 'Something New'
	  expect(page).to have_content "Я"
	  expect(page).to have_content 'Left Title'
	  expect(page).to have_content 'Right Title'
	  expect(page).to have_content 'Text from left'
	  expect(page).to have_content 'Text from right'
	end
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос создан."
	end
	expect(Question.all_first_questions.count).to eq 1
      end
    end

    context 'unsuccessfully' do
      it 'without audience' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in 'field_1q_number', with: 123
	find('#field_1q_subject_1').trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	find('#field_1q_criterion_type_1').trigger 'click'
	click_button 'submit_1q'
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'without number' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in 'field_1q_number', with: ''
	find("#field_1q_audience_1").trigger 'click'
	find("#field_1q_subject_1").trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	find('#field_1q_criterion_type_1').trigger 'click'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'with wrong number' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in 'field_1q_number', with: 'abc123'
	find("#field_1q_audience_1").trigger 'click'
	find("#field_1q_subject_1").trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	find('#field_1q_criterion_type_1').trigger 'click'
	fill_in 'field_1q_left_title', with: 'Left Title'
	fill_in 'field_1q_left_text', with: 'Text from left'
	fill_in 'field_1q_right_title', with: 'Right Title'
	fill_in 'field_1q_right_text', with: 'Text from right'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content 'abc123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).to have_selector '.panel-danger'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'without opinion subject' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in "field_1q_number", with: 123
	find("#field_1q_audience_1").trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	find('#field_1q_criterion_type_1').trigger 'click'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'without criterion' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in "field_1q_number", with: 123
	find("#field_1q_audience_1").trigger 'click'
	find("#field_1q_subject_1").trigger 'click'
	find('#field_1q_criterion_type_1').trigger 'click'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'without criterion_type' do
	fill_in 'field_1q_title', with: 'I want to ask you'
	fill_in "field_1q_number", with: 123
	find("#field_1q_audience_1").trigger 'click'
	find("#field_1q_subject_1").trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end

      it 'without title' do
	fill_in "field_1q_number", with: 123
	find("#field_1q_audience_1").trigger 'click'
	find("#field_1q_subject_1").trigger 'click'
	find('#field_1q_criterion_type_1').trigger 'click'
	fill_in "field_1q_criterion", with: 'Something New'
	click_button "submit_1q"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 0
      end
    end
  end

  describe 'second' do
    before do
      find('#add_second_question').trigger 'click'
    end

    context 'successfully' do
      it 'with audience and sentence only' do
	find('#field_2q_audience_1').trigger 'click'
	fill_in 'field_2q_sentence', with: 'New Sentence'
	click_button "submit_2q"
	within '#admin_second_questions' do
	  expect(page).to have_content 'New Sentence'
	end
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос создан."
	end
	expect(Question.all_second_questions.count).to eq 1
	expect(Question.all_second_questions.last.number).to eq 201
      end
    end
    
    context 'unsuccessfully' do
      it 'without audience' do
	fill_in 'field_2q_sentence', with: 'New Sentence'
	click_button "submit_2q"
	within '#admin_second_questions' do
	  expect(page).not_to have_content 'New Sentence'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_second_questions.count).to eq 0
      end

      it 'without sentence' do
	find('#field_2q_audience_1').trigger 'click'
	click_button "submit_2q"
	within '#admin_second_questions' do
	  expect(page).not_to have_content 'New Sentence'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_second_questions.count).to eq 0
      end
    end
  end
end
