require 'rails_helper'

RSpec.describe 'Admin can update coordinators', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:coordinator) { FactoryGirl.create :coordinator, login: 'login' }

  before do
    sign_in admin
    visit admin_coordinators_path
    find('.edit_coordinator_link').trigger 'click'
  end

  describe 'successfully' do
    after do
      within '#messages .alert-success' do
	expect(page).to have_content "Координатор изменен."
      end
    end

    it 'manually login and password' do
      fill_in 'coordinator_login', with: 'newlogin'
      fill_in 'coordinator_password', with: 'pAssw0rdd'
      click_button "Подтвердить"
      expect(page).to have_content "Логин: newlogin"
    end

    it 'generate login and password' do
      find('.generate_login').trigger 'click'
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      expect(page).not_to have_content "Логин: login"
    end

    it 'generate only password' do
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
    end
  end

  describe 'unsuccessfully' do
    it 'empty login' do
      fill_in 'coordinator_login', with: ""
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      expect(page).to have_selector '.modal.fade.in'
    end

    it 'too long login' do
      fill_in 'coordinator_login', with: "a" * 65
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий логин"
      end
    end

    it 'with taken login' do
      FactoryGirl.create :coordinator, login: 'takenlogin'
      fill_in 'coordinator_login', with: 'takenlogin'
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать другой логин"
      end
    end

    it 'empty password' do
      fill_in 'coordinator_password', with: ""
      click_button "Подтвердить"
      expect(page).to have_selector '.modal.fade.in'
    end

    it 'short password' do
      fill_in 'coordinator_password', with: "123"
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы ввели слишком короткий пароль"
      end
    end

    it 'too long password' do
      fill_in 'coordinator_password', with: "a" * 129
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий пароль"
      end
    end
  end
end
