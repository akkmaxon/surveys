require 'rails_helper'

RSpec.describe 'Manage users by admin', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:user) { FactoryGirl.create :user, login: 'login' }

  before do
    sign_in admin
    visit admin_user_path(user)
  end

  it 'impossible for not admin' do
    sign_out admin
    sign_in user
    visit admin_user_path(user)
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  describe 'successfully' do
    it 'manually login' do
      fill_in 'user_login', with: 'newlogin'
      click_button 'submit_login'
      within '#messages .alert-success' do
	expect(page).to have_content "Логин респондента успешно изменен."
      end
      expect(page).to have_content "Респондент newlogin"
    end

    it 'generate login' do
      find('#generate_login').trigger 'click'
      click_button 'submit_login'
      within '#messages .alert-success' do
	expect(page).to have_content "Логин респондента успешно изменен."
      end
    end

    it 'manually password' do
      fill_in 'user_password', with: 'newpassword'
      click_button 'submit_password'
      within '#messages .alert-success' do
	expect(page).to have_content "Пароль респондента успешно изменен."
      end
    end

    it 'generate password' do
      find('#generate_password').trigger 'click'
      click_button 'submit_password'
      within '#messages .alert-success' do
	expect(page).to have_content "Пароль респондента успешно изменен."
      end
    end
  end

  describe 'unsuccessfully' do
    after do
      expect(page).to have_content "Респондент login"
    end

    it 'empty login' do
      fill_in 'user_login', with: ""
      click_button 'submit_login'
      within '#error_explanation' do
	expect(page).to have_content "Вы должны указать логин"
      end
    end

    it 'too long login' do
      fill_in 'user_login', with: "a" * 65
      click_button 'submit_login'
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий логин"
      end
    end

    it 'with taken login' do
      FactoryGirl.create :user, login: 'takenlogin'
      fill_in 'user_login', with: 'takenlogin'
      click_button 'submit_login'
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать другой логин"
      end
    end

    it 'short password' do
      fill_in 'user_password', with: "123"
      click_button 'submit_password'
      within '#error_explanation' do
	expect(page).to have_content "Вы ввели слишком короткий пароль"
      end
    end

    it 'too long password' do
      fill_in 'user_password', with: "a" * 129
      click_button 'submit_password'
      within '#error_explanation' do
	expect(page).to have_content "Вы должны выбрать более короткий пароль"
      end
    end
  end
end
