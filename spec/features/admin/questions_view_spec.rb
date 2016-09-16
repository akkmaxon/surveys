require 'rails_helper'

RSpec.describe 'Admin can view all questions', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  init_data # 3 1q and 1 2q for management

  before do
    FactoryGirl.create :question, sentence: Faker::Lorem.sentence,
      audience: 'working_staff', number: 201
    sign_in admin
    visit admin_questions_path
  end

  describe 'impossible for' do
    before do
      sign_out admin
    end

    after do
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
      expect(page.current_path).to eq new_admin_session_path
    end

    it 'unsigned user' do
      visit admin_questions_path
    end

    it 'signed user' do
      sign_in FactoryGirl.create :user
      visit admin_questions_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :user
      visit admin_questions_path
    end
  end

  describe 'successfully' do
    it 'page layout' do
      within '#admin_first_questions' do
	expect(page).to have_selector '.question', count: 3
	expect(page).to have_content "Менеджмент", count: 3
      end
      within '#admin_second_questions' do
	expect(page).to have_selector '.question', count: 2
	expect(page).to have_content "Менеджмент", count: 1
	expect(page).to have_content "Рабочая специальность", count: 1
      end
    end

    it 'access from dashboard' do
      visit admin_root_path
      click_link 'questions_link'
      expect(page.current_path).to eq admin_questions_path
    end

    it 'show only management' do
      find('#show_only_management_questions').trigger 'click'
      expect(page).to have_selector '#admin_first_questions .question', count: 3
      expect(page).to have_selector '#admin_second_questions .question', count: 1
      expect(page).not_to have_selector('.working_staff')
    end

    it 'show only working staff' do
      find('#show_only_working_staff_questions').trigger 'click'
      expect(page).not_to have_selector('#admin_first_questions .question')
      expect(page).to have_selector '#admin_second_questions .question', count: 1
      expect(page).not_to have_selector('.management')
    end

    it 'show all questions after filtering' do
      find('#show_only_management_questions').trigger 'click'
      expect(page).not_to have_selector('.working_staff')
      find('#show_only_working_staff_questions').trigger 'click'
      expect(page).not_to have_selector('.management')
      find('#show_all_questions').trigger 'click'
      within '#admin_first_questions' do
	expect(page).to have_selector '.question', count: 3
	expect(page).to have_content "Менеджмент", count: 3
      end
      within '#admin_second_questions' do
	expect(page).to have_selector '.question', count: 2
	expect(page).to have_content "Менеджмент", count: 1
	expect(page).to have_content "Рабочая специальность", count: 1
      end
    end
  end
end

