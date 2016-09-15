require 'rails_helper'

RSpec.describe 'Admin can create coordinators', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admin_coordinators_path
    find('#add_coordinator_link').trigger 'click'
  end

  describe 'Successfully' do
    after do
      within '#messages .alert-success' do
	expect(page).to have_content "Координатор создан."
      end
      expect(Coordinator.count).to eq 1
    end

    it 'manually enter properties' do
      fill_in "Логин", with: 'coord123'
      fill_in "Пароль", with: 'pAssw0rd'
      click_button "Подтвердить"
      expect(Coordinator.first.login).to eq 'coord123'
      expect(Coordinator.first.decrypted_password).to eq 'pAssw0rd'
    end

    it 'generate login' do
      find('.generate_login').trigger 'click'
      fill_in "Пароль", with: 'pAssw0rd'
      click_button "Подтвердить"
      expect(Coordinator.first.decrypted_password).to eq 'pAssw0rd'
    end

    it 'generate password' do
      fill_in "Логин", with: 'coord123'
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
      expect(Coordinator.first.login).to eq 'coord123'
    end

    it 'generating login/password' do
      find('.generate_login').trigger 'click'
      find('.generate_password').trigger 'click'
      click_button "Подтвердить"
    end
  end

  describe 'unsuccessfully' do
    after do
      expect(Coordinator.count).to eq 0
    end

    it 'with empty login' do
      fill_in "Пароль", with: 'password'
      click_button "Подтвердить"
      expect(page.current_path).to eq admin_coordinators_path
    end

    it 'with login only' do
      fill_in "Логин", with: 'coordinator1'
      click_button "Подтвердить"
      expect(page.current_path).to eq admin_coordinators_path
    end	

    it 'with short password' do
      fill_in "Логин", with: 'coordinator1'
      fill_in "Пароль", with: 'passw'
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "короткий пароль"
      end
    end

    it 'with too long login' do
      fill_in "Логин", with: 'a' * 65
      fill_in "Пароль", with: 'password'
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "слишком длинный логин"
      end
    end

    it 'with too long password' do
      fill_in "Логин", with: 'user1'
      fill_in "Пароль", with: 'a' * 129
      click_button "Подтвердить"
      within '#error_explanation' do
	expect(page).to have_content "слишком длинный пароль"
      end
    end
  end
end
