require 'rails_helper'

RSpec.describe 'Admin can view all users', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
  end

  it 'only admin can do it' do
    sign_out admin
    sign_in FactoryGirl.create :user
    visit admin_users_path
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'page layout' do
    3.times { FactoryGirl.create :user }
    visit admin_users_path
    expect(page).to have_selector '#all_users'
    expect(page).to have_selector '.user', count: 3
    expect(page).to have_selector '.active #users_link'
    expect(page).to have_selector 'a#add_user_link'
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
