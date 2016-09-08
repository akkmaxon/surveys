require 'rails_helper'

RSpec.describe 'Manage users by admin', type: :feature do
  def go_to_admin_login
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
  end

  describe 'Show users' do
    context 'list all users' do
      it 'only admin can do it' do
	sign_out admin
	sign_in FactoryGirl.create :user
	visit admin_users_path
	go_to_admin_login
      end

      it 'page layout' do
	3.times { FactoryGirl.create :user }
	visit admin_users_path
	expect(page).to have_selector '#all_users'
	expect(page).to have_selector '.user', count: 3
	expect(page).to have_selector '.active #users_link'
	expect(page).to have_selector 'a#add_user'
	expect(page).to have_selector 'a.show_user'
      end

      it 'add new users successfully' do
	visit admin_users_path
	expect(page).not_to have_selector '#all_users .user'
	visit new_admin_user_path
	fill_in "Логин", with: 'user123'
	fill_in "Пароль", with: 'password'
	click_button "Создать"
	visit admin_users_path
	expect(page).to have_selector '#all_users .user', count: 1
      end
    end

    context 'show one user' do
      let!(:user) { FactoryGirl.create :user, id: 5 }

      it 'only admin can do it' do
	sign_out admin
	sign_in user
	visit admin_user_path(user)
	go_to_admin_login
      end

      it 'visit from users#index page' do
	visit admin_users_path
	click_link user.login
	expect(page.current_path).to eq "/admin/users/5"
	within '.header' do
	  expect(page).to have_content user.login
	end
      end

      it 'page layout' do
	visit admin_user_path(user)
	expect(page).to have_selector '#login'
	expect(page).to have_selector '#password'
	expect(page).to have_selector 'a#surveys'
      end
    end
  end

  describe 'Creating users' do
    before do
      visit new_admin_user_path
    end

    it 'impossible visit page for not admin' do
      sign_out admin
      sign_in FactoryGirl.create :user
      visit new_admin_user_path
      go_to_admin_login
    end

    context 'successfully' do
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

    context 'unsuccessfully' do
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

  describe 'Update users' do
    let!(:user) { FactoryGirl.create :user, login: 'login' }

    before do
      visit admin_user_path(user)
    end

    it 'impossible for not admin' do
      sign_out admin
      sign_in user
      visit admin_user_path(user)
      go_to_admin_login
    end

    context 'successfully' do
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

    context 'unsuccessfully' do
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
end
