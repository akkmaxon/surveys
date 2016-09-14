require 'rails_helper'

RSpec.describe 'Admin can view one user', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:user) { FactoryGirl.create :user, id: 5 }

  before do
    sign_in admin
  end

  it 'only admin can do it' do
    sign_out admin
    sign_in user
    visit admin_user_path(user)
    expect(page.current_path).to eq new_admin_session_path
    within '#messages .alert-danger' do
      expect(page).to have_content "Войдите, пожалуйста, в систему"
    end
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
