require 'rails_helper'

RSpec.describe 'Admin can view all users', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    3.times { FactoryGirl.create :user }
  end

  it 'only admin can do it' do
    sign_out admin
    sign_in User.first
    visit admin_users_path
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
  end

  it 'page layout' do
    visit admin_users_path
    expect(page).to have_selector '#all_users'
    expect(page).to have_selector '.user', count: 3
    expect(page).to have_selector '.active #users_link'
    expect(page).to have_selector 'a#add_user_link'
    expect(page).to have_content "Логин:", count: 3
    expect(page).to have_content "Пароль:", count: 3
  end
end
