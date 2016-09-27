require 'rails_helper'

RSpec.describe 'Coordinator can search and', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }
  ### users
  let!(:user1) { FactoryGirl.create :user, login: 'user1' }
  let!(:user2) { FactoryGirl.create :user, login: 'user2' }
  let!(:user3) { FactoryGirl.create :user, login: 'user3' }
  ### surveys
  let!(:survey1) { FactoryGirl.create :survey, user: user1, completed: true, user_email: 'first@email.com' }
  let!(:survey2) { FactoryGirl.create :survey, user: user2, completed: true, user_email: 'second@email.com' }
  let!(:survey3) { FactoryGirl.create :survey, user: user3, completed: true, user_email: 'third@email.com' }

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

  it 'find all survey by email' do
    fill_in id: 'search_field', with: '@email'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
      expect(page).to have_selector '.show_survey', count: 3
      expect(page).to have_content 'first@email.com'
      expect(page).to have_content 'second@email.com'
      expect(page).to have_content 'third@email.com'
    end
  end

  it 'find one survey by email' do
    fill_in id: 'search_field', with: 'first'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_selector '.show_survey', count: 1
      expect(page).to have_content 'first@email.com'
    end
  end
end
