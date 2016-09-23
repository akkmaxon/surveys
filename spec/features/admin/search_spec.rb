require 'rails_helper'

RSpec.describe 'Admin can search and', type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  ### users
  let!(:user1) { FactoryGirl.create :user, login: 'user1' }
  let!(:user2) { FactoryGirl.create :user, login: 'user2' }
  let!(:user3) { FactoryGirl.create :user, login: 'user3' }
  ### coordinators
  let!(:coord1) { FactoryGirl.create :coordinator, login: 'coordinator1' }
  let!(:coord2) { FactoryGirl.create :coordinator, login: 'coordinator2' }
  let!(:coord3) { FactoryGirl.create :coordinator, login: 'coordinator3' }
  ### companies
  let!(:company1) { FactoryGirl.create :company, name: 'company1' }
  let!(:company2) { FactoryGirl.create :company, name: 'company2' }
  let!(:company3) { FactoryGirl.create :company, name: 'company3' }
  ### questions

  before do
    sign_in admin
    visit admin_root_path
  end

  it 'redirect proper page' do
    fill_in id: 'search_field', with: 'abcdef'
    click_button 'search_button'
    expect(page.current_path).to eq admin_search_path
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

  it 'find only one coordinator' do
    fill_in id: 'search_field', with: 'coordinator2'
    click_button 'search_button'
    within '#masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_content 'coordinator2'
      expect(page).to have_selector '.edit_coordinator_link'
    end
  end

  it 'find all the coordinators' do
    fill_in id: 'search_field', with: 'coordinator'
    click_button 'search_button'
    within '#masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
    end
  end

  it 'find only one company'
  it 'find all the companies'
  it 'find only one question'
end
