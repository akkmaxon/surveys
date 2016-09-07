require 'rails_helper'

RSpec.describe "Admin can manage companies", type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admin_companies_path
  end

  describe "view" do
    let!(:company) { FactoryGirl.create :company, name: 'New Company' }

    it 'impossible for not admin' do
      sign_out admin
      sign_in FactoryGirl.create :user
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
      click_button "Добавить"
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
      click_button "Добавить"
      within '#messages .alert-danger' do
	expect(page).to have_content "Невозможно создать компанию"
      end
      expect(page).not_to have_selector '.company'
    end
  end

  describe "updating" do
    it 'with valid name'
    it 'with empty name'
  end

  describe "deleting" do
    it 'successfully'
  end
end
