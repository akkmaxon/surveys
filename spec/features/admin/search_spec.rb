require 'rails_helper'

RSpec.describe 'Admin can search', type: :feature do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
    visit admin_root_path
  end

  describe 'users' do
    let!(:user1) { FactoryGirl.create :user, login: 'user1' }
    let!(:user2) { FactoryGirl.create :user, login: 'user2' }
    let!(:user3) { FactoryGirl.create :user, login: 'user3' }

    it 'redirect proper page' do
      fill_in id: 'search_field', with: 'abcdef'
      click_button 'search_button'
      expect(page.current_path).to eq admin_search_path
    end

    it 'find nothing' do
      fill_in id: 'search_field', with: 'abcdef'
      click_button 'search_button'
      expect(page).to have_content "найти не удалось"
    end

    it 'find only one user' do
      fill_in id: 'search_field', with: 'er2'
      click_button 'search_button'
      within '#masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_content 'user2'
	expect(page).to have_selector '.edit_user_link'
      end
    end

    it 'find all the users' do
      fill_in id: 'search_field', with: 'user'
      click_button 'search_button'
      within '#masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
      end
    end
  end

  describe 'coordinators' do
  end

  describe 'companies' do
  end

  describe 'questions' do
  end
end
