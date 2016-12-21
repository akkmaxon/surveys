require 'rails_helper'

RSpec.describe 'Coordinator can view users', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  before do
    3.times { FactoryGirl.create :user }
  end

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_users_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create :user
      visit coordinators_users_path
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit coordinators_users_path
    end
  end

  describe 'successfully' do
    before do
      sign_in coordinator
    end

    it 'without filters' do
      visit coordinators_root_path
      click_link 'users_link'
      expect(page.current_path).to eq coordinators_users_path
      expect(page).to have_selector '.masonry_container'
      expect(page).to have_selector '.active #users_link'
      expect(page).to have_selector '.user', count: 3
      expect(page).to have_selector 'a.show_report', count: 3
    end

    context 'for specific company' do
      let!(:company) { Company.create!(name: "Company") }

      it 'with an employee' do
	user = FactoryGirl.create(:user, login: 'Company User')
	FactoryGirl.create(:info, user: user, company: company.name)
	expect(User.count).to eq(4)

	visit coordinators_companies_path
	find('.show_company_users').trigger('click')
	expect(page.current_path).to eq(coordinators_users_path)
	expect(page).to have_content("Респонденты (#{company.name}) 1")
	expect(page).to have_selector('.masonry_container .user', count: 1)
	within('.masonry_container .user') do
	  expect(page).to have_content(user.login)
	end
      end

      it 'without employees' do
	visit coordinators_companies_path
	find('.show_company_users').trigger('click')
	expect(page.current_path).to eq(coordinators_users_path)
	expect(page).to have_content("Респонденты (#{company.name}) 0")
	expect(page).to have_selector('.masonry_container .user', count: 0)
      end
    end
  end
end
