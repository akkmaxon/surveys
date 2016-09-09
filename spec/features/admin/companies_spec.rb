require 'rails_helper'

RSpec.describe "Admin can manage companies", type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admin_companies_path
  end

  describe "view" do
    let!(:company) { FactoryGirl.create :company, name: 'New Company' }

    it 'impossible for signed in user' do
      sign_out admin
      sign_in FactoryGirl.create :user
      visit admin_companies_path
      expect(page.current_path).to eq new_admin_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'impossible for unsigned in user' do
      sign_out admin
      visit admin_companies_path
      expect(page.current_path).to eq new_admin_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'access from dashboard' do
      visit admin_root_path
      click_link "Компании"
      expect(page.current_path).to eq admin_companies_path
    end

    it 'page layout' do
      visit admin_companies_path
      expect(page).to have_selector '#add_company'
      expect(page).not_to have_selector '#new_company'
      expect(page).to have_selector '#all_companies'
      expect(page).to have_selector '.company', count: 1
      expect(page).to have_content 'New Company'
    end
  end

  describe "creating" do
    it 'with valid name' do
      find('#add_company').trigger 'click'
      fill_in "Имя компании", with: 'NEW COMPANY'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Список компаний расширен."
      end
      within '#all_companies' do
	expect(page).to have_selector '.company', count: 1
	expect(page).to have_content "NEW COMPANY"
      end
    end

    it 'with empty name' do
      find('#add_company').trigger 'click'
      fill_in "Имя компании", with: ''
      click_button "Подтвердить"
      visit admin_companies_path
      expect(page).not_to have_selector '.company'
      expect(Company.count).to eq 0
    end
  end

  describe "updating" do
    let!(:company) { FactoryGirl.create :company }

    before do
      visit admin_companies_path
      find('.company .update_company').trigger 'click'
    end

    it 'with valid name' do
      fill_in "Имя компании", with: 'NEW COMPANY'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Список компаний обновлен."
      end
      expect(page).to have_content 'NEW COMPANY'
    end

    it 'with empty name' do
      fill_in "Имя компании", with: ''
      click_button "Подтвердить"
      company.reload
      expect(company.name).not_to eq ''
    end
  end

  describe "deleting" do
    it 'successfully' do
      FactoryGirl.create :company
      visit admin_companies_path
      expect(page).to have_selector '.company'
      find('.company .delete_company').trigger 'click'
      within '#messages .alert-success' do
	expect(page).to have_content "Компания удалена."
      end
      expect(page).not_to have_selector '.company'
    end    
  end
end
