require 'rails_helper'

RSpec.describe 'Coordinator can view all the work positions', type: :feature do
  fixtures :work_positions, :companies

  let(:coordinator) { FactoryGirl.create :coordinator }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_work_positions_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create(:user)
      visit coordinators_work_positions_path
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
      visit coordinators_work_positions_path
    end
  end

  describe 'successfully' do
    before do
      sign_in coordinator
    end

    it 'access from dropdown menu' do
      visit coordinators_root_path
      click_link 'work_positions_link'
      first('.work_positions_company').trigger('click')
      expect(page.current_path).to eq(coordinators_work_positions_path)
    end

    it 'access from company' do
      visit coordinators_companies_path
      first('.show_company_work_positions').trigger('click')
      expect(page.current_path).to eq(coordinators_work_positions_path)
    end

    it 'page layout with filter' do
      visit coordinators_root_path
      click_link 'work_positions_link'
      first('.work_positions_company').trigger('click')
      expect(page).to have_content("Должности (#{companies(:one).name}) 3") 
      expect(page).to have_selector('.masonry_container')
      expect(page).to have_selector('.active #work_positions_link')
      expect(page).to have_selector('.work_position', count: 3)
      expect(page).to have_selector('a.show_report', count: 3)
    end

    it 'page layout without filter' do
      visit coordinators_root_path
      click_link 'work_positions_link'
      click_link 'work_positions_all_companies'
      expect(page).to have_content("Должности 3")
      expect(page).to have_selector('.work_position', count: 3)
      expect(page).to have_selector('a.show_report', count: 3)
    end
  end
end
