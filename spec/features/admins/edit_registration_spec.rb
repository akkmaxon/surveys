require 'rails_helper'

RSpec.describe 'Admin can edit own profile', type: :feature do
  let(:current_password) { 'password' }
  let(:admin) { FactoryGirl.create :admin, login: 'login', email: 'admin@email.com', password: current_password }

  before do
    sign_in admin
    visit edit_admin_registration_path
  end
  
  describe 'successfully' do
    after do
      within '#messages .alert-success' do
	expect(page).to have_content "Профиль обновлен"
      end
      expect(page.current_path).to eq admins_users_path
      expect(Admin.first.login).to eq 'newadmin'
      expect(Admin.first.email).to eq 'newemail@newadmin.com'
    end

    it 'with all fields' do
      fill_in "Логин", with: 'newadmin'
      fill_in "Email", with: 'newemail@newadmin.com'
      fill_in "Пароль", with: 'newpassword'
      fill_in "Подтверждение пароля", with: 'newpassword'
      fill_in "Текущий пароль", with: current_password
      click_button "Подтвердить"
    end

    it 'without password' do
      fill_in "Логин", with: 'newadmin'
      fill_in "Email", with: 'newemail@newadmin.com'
      fill_in "Текущий пароль", with: current_password
      click_button "Подтвердить"
    end
  end

  describe 'unsuccessfully' do
    context 'for' do
      before do
	sign_out admin
      end

      after do
	expect(page.current_path).to eq new_admin_session_path
	within '#messages .alert-danger' do
	  expect(page).to have_content "Войдите, пожалуйста, в систему"
	end
      end

      it 'unsigned in user' do
	visit edit_admin_registration_path
      end

      it 'signed in user' do
	sign_in FactoryGirl.create :user
	visit edit_admin_registration_path
      end

      it 'coordinator' do
	sign_in FactoryGirl.create :coordinator
	visit edit_admin_registration_path
      end
    end

    context 'for admin' do
      after do
	expect(Admin.first.login).to eq 'login'
	expect(Admin.first.email).to eq 'admin@email.com'
      end

      it 'with empty login' do
	fill_in "Логин", with: ''
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	expect(page.current_path).to eq edit_admin_registration_path
      end

      it 'with too long login' do
	fill_in "Логин", with: 'a' * 65
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "не более 64"
	end
      end

      it 'with empty email' do
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: ''
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	expect(page.current_path).to eq edit_admin_registration_path
      end

      it 'with wrong email' do
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'a_am_wrong'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "указан неверно"
	end
      end

      it 'with short password' do
	short_pass = 'abc'
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: short_pass
	fill_in "Подтверждение пароля", with: short_pass
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "не менее 6"
	end
      end

      it 'with too long password' do
	long_pass = 'a' * 129
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: long_pass
	fill_in "Подтверждение пароля", with: long_pass
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "не более 128"
	end
      end

      it 'with bad confirmation password' do
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpasswd'
	fill_in "Текущий пароль", with: current_password
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "неверно"
	end
      end

      it 'without current password' do
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: ''
	click_button "Подтвердить"
	expect(page.current_path).to eq edit_admin_registration_path
      end

      it 'with invalid current password' do
	fill_in "Логин", with: 'newadmin'
	fill_in "Email", with: 'newemail@newadmin.com'
	fill_in "Пароль", with: 'newpassword'
	fill_in "Подтверждение пароля", with: 'newpassword'
	fill_in "Текущий пароль", with: 'abc123'
	click_button "Подтвердить"
	within '#error_explanation' do
	  expect(page).to have_content "указан неверно"
	end
      end
    end
  end
end
