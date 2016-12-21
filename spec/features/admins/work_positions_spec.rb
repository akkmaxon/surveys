require 'rails_helper'

RSpec.describe "Admin manage work_positions", type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  describe "view" do
    context 'impossible for' do
      after do
	expect(page.current_path).to eq new_admin_session_path
	within '#messages .alert-danger' do
	  expect(page).to have_content "Войдите, пожалуйста, в систему"
	end
      end

      it 'signed in user' do
	sign_in FactoryGirl.create(:user)
	visit admins_companies_path
      end

      it 'unsigned in user' do
	visit admins_companies_path
      end

      it 'coordinator' do
	sign_in FactoryGirl.create(:coordinator)
	visit admins_companies_path
      end
    end

    it 'page layout' do
      sign_in admin
      visit admins_work_positions_path
      expect(page).to have_selector '#add_work_position'
      expect(page).not_to have_selector '#new_work_position'
      expect(page).to have_selector '.masonry_container'
      expect(page).to have_selector '.work_position', count: 3
      expect(page).to have_content 'FirstWorkPosition'
      expect(page).to have_content 'SecondWorkPosition'
      expect(page).to have_content 'ThirdWorkPosition'
    end
  end

  describe "create" do
    before do
      sign_in admin
    end

    it 'with valid title' do
      find('#add_work_position').trigger 'click'
      fill_in id: 'work_position_title', with: 'New WorkPosition'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Должность добавлена"
      end
      within '.masonry_container' do
	expect(page).to have_selector '.work_positions', count: 4
	expect(page).to have_content 'New WorkPosition'
      end
      expect(WorkPosition.count).to eq 4
    end

    it 'with empty title' do
      find('#add_work_position').trigger 'click'
      fill_in id: 'work_position_title', with: ''
      click_button "Подтвердить"
      visit admins_work_positions_path
      expect(page).to have_selector '.work_positions', count: 3
      expect(WorkPosition.count).to eq 3
    end
  end

  describe "update" do
    before do
      visit admins_companies_path
      first('.work_positions .edit_work_position_link').trigger 'click'
    end

    it 'with valid title' do
      expect(page).not_to have_content 'New WorkPosition'

      fill_in id: 'work_position_title', with: 'New WorkPosition'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Должность обновлена"
      end
      expect(page).to have_content 'New WorkPosition'
    end

    it 'with empty title' do
      fill_in id: 'work_position_title', with: ''
      click_button "Подтвердить"
      expect(page).not_to have_selector('#messages .alert-success')
      expect(WorkPosition.find_by(name: '')).to be_nil
    end
  end

  describe "delete" do
    it 'successfully' do
      visit admins_work_positions_path
      expect(page).to have_selector '.work_positions', count: 3
      find('.work_positions .delete_work_position').trigger 'click'
      within '#messages .alert-success' do
	expect(page).to have_content "Должность удалена"
      end
      expect(page.current_path).to eq(admins_work_positions_path)
      expect(page).to have_selector '.work_positions', count: 2
    end    
  end
end
