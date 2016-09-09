require 'rails_helper'

RSpec.describe 'Admin can update questions', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let(:q1) { FactoryGirl.create :question }
  let!(:left_q1) { FactoryGirl.create :left_statement, question: q1 }
  let!(:right_q1) { FactoryGirl.create :right_statement, question: q1 }
  let(:q2) { FactoryGirl.create :question, sentence: Faker::Lorem.sentence }

  before do
    sign_in admin
    visit admin_questions_path
  end

  describe 'first' do
    before do
      find('#admin_first_questions .update_question').trigger 'click'
    end

    context 'successfully' do
      after do
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос обновлен."
	end
      end

      it 'changing nothing' do
	click_button 'update_1q'
      end

      it 'changing one thing' do
	fill_in 'edit_1q_criterion', with: 'New Criterion'
	click_button 'update_1q'
	expect(page).to have_content 'New Criterion'
      end

      it 'changing all properties' do
	fill_in 'edit_1q_number', with: 123
	find('#edit_1q_audience_1').trigger 'click'
	fill_in 'edit_1q_left_title', with: 'New Left Title'
	fill_in 'edit_1q_left_text', with: 'New Left Text'
	fill_in 'edit_1q_right_title', with: 'New Right Title'
	fill_in 'edit_1q_right_text', with: 'New Right Text'
	find('#edit_1q_subject_1').trigger 'click'
	fill_in 'edit_1q_criterion', with: 'New Criterion'
	click_button 'update_1q'
	within '#admin_first_questions' do
	  expect(page).to have_content '123'
	  expect(page).to have_content "Менеджмент"
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
      it 'with empty number'
      it 'with empty criterion'
      it 'with empty left title'
      it 'with empty left text'
      it 'with empty right title'
      it 'with empty right text'
    end
  end

  describe 'second' do
    context 'successfully' do
      it 'changing nothing'
      it 'changing all'
    end

    context 'unsuccessfully' do
      it 'with empty sentence'
    end
  end
end
