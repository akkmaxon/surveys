require 'rails_helper'

RSpec.describe 'Admin can create users', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit new_admin_user_path
  end

  it 'impossible visit page for not admin' do
    sign_out admin
    sign_in FactoryGirl.create :user
    visit new_admin_user_path
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  describe 'Successfully' do
    after do
      within '#messages .alert-success' do
	expect(page).to have_content "Новый респондент успешно создан."
      end
      expect(User.count).to eq 1
    end

    it 'manually enter properties' do
      fill_in "Логин", with: 'user123'
      fill_in "Пароль", with: 'password'
      click_button "Создать"
      expect(page).to have_content "Логин: user123"
      expect(page).to have_content "Пароль: password"
      expect(User.first.login).to eq 'user123'
    end

    it 'generate login' do
      find('#generate_login').trigger 'click'
      fill_in "Пароль", with: 'password'
      click_button "Создать"
    end

    it 'generate password' do
      fill_in "Логин", with: 'user123'
      find('#generate_password').trigger 'click'
      click_button "Создать"
      expect(User.first.login).to eq 'user123'
    end

    it 'generating login/password' do
      find('#generate_login').trigger 'click'
      find('#generate_password').trigger 'click'
      click_button "Создать"
    end
  end

  describe 'unsuccessfully' do
    after do
      within '#error_explanation' do
	expect(page).not_to have_content 'Login'
	expect(page).not_to have_content 'Password'
      end
    end

    it 'with empty login' do
      fill_in "Пароль", with: 'password'
      click_button "Создать"
      expect(page).to have_selector '#error_explanation ul li', count: 1
    end

    it 'with login only' do
      fill_in "Логин", with: 'user1'
      click_button "Создать"
      expect(page).to have_selector '#error_explanation ul li', count: 1
    end	

    it 'with short password' do
      fill_in "Логин", with: 'user1'
      fill_in "Пароль", with: 'passw'
      click_button "Создать"
      expect(page).to have_selector '#error_explanation ul li', count: 1
    end

    it 'with too long login' do
      fill_in "Логин", with: 'a' * 65
      fill_in "Пароль", with: 'password'
      click_button "Создать"
      expect(page).to have_selector '#error_explanation ul li', count: 1
    end

    it 'with too long password' do
      fill_in "Логин", with: 'user1'
      fill_in "Пароль", with: 'a' * 129
      click_button "Создать"
      expect(page).to have_selector '#error_explanation ul li', count: 1
    end
  end
end
