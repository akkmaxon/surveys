require 'rails_helper'

RSpec.describe 'Coordinator can search and', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }
  ### users
  let!(:user1) { FactoryGirl.create :user, login: 'user1' }
  let!(:user2) { FactoryGirl.create :user, login: 'user2' }
  let!(:user3) { FactoryGirl.create :user, login: 'user3' }

  before do
    sign_in coordinator
    visit coordinator_root_path
  end

  it 'redirect proper page' do
    fill_in id: 'search_field', with: 'abcdef'
    click_button 'search_button'
    expect(page.current_path).to eq coordinator_search_path
  end

  it 'find nothing if query is empty' do
    fill_in id: 'search_field', with: ''
    click_button 'search_button'
    expect(page).to have_content "найти не удалось"
  end

  it 'find nothing if query is valid' do
    fill_in id: 'search_field', with: 'abcdef'
    click_button 'search_button'
    expect(page).to have_content "найти не удалось"
  end

  it 'find only one user' do
    fill_in id: 'search_field', with: 'user2'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_content 'user2'
      expect(page).to have_selector '.show_surveys', count: 1
    end
  end

  it 'find all the users' do
    fill_in id: 'search_field', with: 'user'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
    end
  end
end
