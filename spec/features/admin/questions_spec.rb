require 'rails_helper'

RSpec.describe 'Admin can manage all questions', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  init_data # 3 1q and 1 2q for management

  before do
    FactoryGirl.create :question, sentence: Faker::Lorem.sentence,
      audience: 'working_staff', number: 201
    sign_in admin
    visit admin_questions_path
  end

  describe 'impossible for' do
    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
      expect(page.current_path).to eq new_admin_session_path
    end

    it 'unsigned user' do
      sign_out admin
      visit admin_questions_path
    end

    it 'signed user' do
      sign_out admin
      sign_in FactoryGirl.create :user
      visit admin_questions_path
    end
  end

  describe 'viewing' do
    it 'page layout' do
      expect(page).to have_selector '#admin_first_questions'
      expect(page).to have_selector '#admin_second_questions'
      expect(page).to have_selector '#admin_first_questions .question', count: 3
      expect(page).to have_selector '#admin_second_questions .question', count: 2
      expect(page).to have_content "Менеджмент", count: 4
      expect(page).to have_content "Рабочая специальность", count: 1
    end

    it 'access from dashboard' do
      visit admin_root_path
      click_link 'questions_link'
      expect(page.current_path).to eq admin_questions_path
    end
  end

  describe 'creation' do
    before do
      find('#add_question .dropdown-toggle').trigger 'click'
    end

    context 'successfully' do
      it 'first question' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: 123
	find("#new_first_question_management").trigger 'click'
	find("#new_question_me").trigger 'click'
	fill_in "new_criterion", with: 'Something New'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).to have_content '123'
	  expect(page).to have_content 'Something New'
	end
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос создан."
	end
	expect(Question.all_first_questions.count).to eq 4
      end

      it 'second question' do
	find('#add_second_question').trigger 'click'
	find('#new_second_question_management').trigger 'click'
	fill_in 'new_sentence', with: 'New Sentence'
	click_button "add_2"
	within '#admin_second_questions' do
	  expect(page).to have_content 'New Sentence'
	end
	within '#messages .alert-success' do
	  expect(page).to have_content "Вопрос создан."
	end
	expect(Question.all_second_questions.count).to eq 3
	expect(Question.all_second_questions.last.number).to eq 202
      end
    end

    context 'unsuccessfully' do
      it 'first without audience' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: 123
	find("#new_question_me").trigger 'click'
	fill_in "new_criterion", with: 'Something New'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 3
      end

      it 'second without audience' do
	find('#add_second_question').trigger 'click'
	fill_in 'new_sentence', with: 'New Sentence'
	click_button "add_2"
	within '#admin_second_questions' do
	  expect(page).not_to have_content 'New Sentence'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_second_questions.count).to eq 2
      end

      it 'first without number' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: ''
	find("#new_first_question_management").trigger 'click'
	find("#new_question_me").trigger 'click'
	fill_in "new_criterion", with: 'Something New'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 3
      end

      it 'first with wrong number' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: 'abc123'
	find("#new_first_question_management").trigger 'click'
	find("#new_question_me").trigger 'click'
	fill_in "new_criterion", with: 'Something New'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).not_to have_content 'abc123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).to have_selector '#error_explanation'
	expect(Question.all_first_questions.count).to eq 3
      end

      it 'first without opinion subject' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: 123
        find("#new_first_question_management").trigger 'click'
	fill_in "new_criterion", with: 'Something New'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	  expect(page).not_to have_content 'Something New'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 3
      end

      it 'first without criterion' do
	find('#add_first_question').trigger 'click'
	fill_in "Номер вопроса", with: 123
	find("#new_first_question_management").trigger 'click'
	find("#new_question_me").trigger 'click'
	click_button "add_1"
	within '#admin_first_questions' do
	  expect(page).not_to have_content '123'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_first_questions.count).to eq 3
      end

      it 'second without sentence' do
	find('#add_second_question').trigger 'click'
	find('#new_second_question_management').trigger 'click'
	click_button "add_2"
	within '#admin_second_questions' do
	  expect(page).not_to have_content 'New Sentence'
	end
	expect(page).not_to have_selector '#messages .alert'
	expect(Question.all_second_questions.count).to eq 2
      end
    end
  end

  describe 'updating' do
    context 'successfully' do
    end

    context 'unsuccessfully' do
    end
  end

  describe 'deleting' do
    before do
      Question.destroy_all
    end

    it 'successfully first question' do
      FactoryGirl.create :question, sentence: ""
      visit admin_questions_path
      expect(Question.all_first_questions.count).to eq 1
      find('#admin_first_questions .delete_question').trigger 'click'
      within '#messages .alert-success' do
	expect(page).to have_content "Вопрос удален."
      end
      expect(Question.all_first_questions.count).to eq 0
    end

    it 'successfully second question' do
      FactoryGirl.create :question, sentence: Faker::Lorem.sentence
      visit admin_questions_path
      expect(Question.all_second_questions.count).to eq 1
      find('#admin_second_questions .delete_question').trigger 'click'
      within '#messages .alert-success' do
	expect(page).to have_content "Вопрос удален."
      end
      expect(Question.all_second_questions.count).to eq 0
    end
  end
end
