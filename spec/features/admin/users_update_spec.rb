require 'rails_helper'

RSpec.describe 'Admin can update users', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:user) { FactoryGirl.create :user, login: 'login' }

  before do
    sign_in admin
    visit admin_users_path
    find('.edit_user_link').trigger 'click'
  end

  describe 'successfully' do
    it 'manually login' do
      fill_in 'user_login', with: 'newlogin'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Респондент изменен."
      end
      expect(page).to have_content "Логин: newlogin"
    end

    it 'generate login' do
      find('.generate_login').trigger 'click'
      click_button "Подтвердить"
      sleep 1
      within '#messages .alert-success' do
	expect(page).to have_content "Респондент изменен."
      end
    end

    it 'manually password' do
      fill_in 'user_password', with: 'newpassword'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Респондент изменен."
      end
    end

    it 'generate password' do
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Респондент изменен."
      end
    end
  end

  describe 'unsuccessfully' do
    it 'empty login' do
      fill_in 'user_login', with: ""
      click_button "Подтвердить"
      expect(page).to have_selector '.modal.fade.in'
    end

    it 'too long login' do
      fill_in 'user_login', with: "a" * 65
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий логин"
      end
    end

    it 'with taken login' do
      FactoryGirl.create :user, login: 'takenlogin'
      fill_in 'user_login', with: 'takenlogin'
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать другой логин"
      end
    end

    it 'short password' do
      fill_in 'user_password', with: "123"
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы ввели слишком короткий пароль"
      end
    end

    it 'too long password' do
      fill_in 'user_password', with: "a" * 129
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий пароль"
      end
    end
  end
end
