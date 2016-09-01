require 'rails_helper'

RSpec.describe 'Authentication for admin', type: :feature do
  describe 'login' do
    let!(:user) { FactoryGirl.create :user }
    let!(:admin) { FactoryGirl.create :admin }

    it 'successfully' do
      visit new_admin_session_path
      fill_in "Логин", with: admin.login
      fill_in "Пароль", with: admin.password
      click_button "Войти"
      expect(page).to have_selector '#messages .alert-success'
      expect(page.current_path).to eq admin_root_path
    end

    context 'unsuccessful' do
      before do
	visit new_admin_session_path
      end

      after do
	click_button "Войти"
	expect(page).to have_selector '#messages .alert-danger'
      end

      it 'login empty' do
	fill_in "Логин", with: ''
	fill_in "Пароль", with: admin.password
      end

      it 'login wrong' do
	fill_in "Логин", with: user.login
	fill_in "Пароль", with: admin.password
      end
      
      it 'password empty' do
	fill_in "Логин", with: admin.login
	fill_in "Пароль", with: ''
      end

      it 'password wrong' do
	fill_in "Логин", with: admin.login
	fill_in "Пароль", with: 'wrongpassword'
      end
    end
  end
end
