require 'rails_helper'

RSpec.describe "Admin manage work_positions", type: :feature do
  fixtures :work_positions

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
	visit admins_work_positions_path
      end

      it 'unsigned in user' do
	visit admins_work_positions_path
      end

      it 'coordinator' do
	sign_in FactoryGirl.create(:coordinator)
	visit admins_work_positions_path
      end
    end

    it 'access for admin' do
      sign_in admin
      visit root_path
      find('#work_positions_link').trigger('click')
      expect(page.current_path).to eq(admins_work_positions_path)
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
      visit admins_work_positions_path
    end

    it 'with valid title' do
      find('#add_work_position').trigger 'click'
      fill_in id: 'work_position_title', with: 'New WorkPosition'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Должность добавлена"
      end
      within '.masonry_container' do
	expect(page).to have_selector '.work_position', count: 4
	expect(page).to have_content 'New WorkPosition'
      end
      expect(WorkPosition.count).to eq 4
    end

    it 'with empty title' do
      find('#add_work_position').trigger 'click'
      fill_in id: 'work_position_title', with: ''
      click_button "Подтвердить"
      visit admins_work_positions_path
      expect(page).to have_selector '.work_position', count: 3
      expect(WorkPosition.count).to eq 3
    end
  end

  describe "update" do
    before do
      sign_in admin
      visit admins_work_positions_path
      first('.work_position .edit_work_position_link').trigger 'click'
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
      expect(WorkPosition.find_by(title: '')).to be_nil
    end
  end

  describe "delete" do
    before do
      sign_in admin
      visit admins_work_positions_path
    end

    it 'successfully' do
      expect(page).to have_selector '.work_position', count: 3
      first('.work_position .delete_work_position').trigger 'click'
      within '#messages .alert-success' do
	expect(page).to have_content "Должность удалена"
      end
      expect(page.current_path).to eq(admins_work_positions_path)
      expect(page).to have_selector '.work_position', count: 2
    end    
  end
end
