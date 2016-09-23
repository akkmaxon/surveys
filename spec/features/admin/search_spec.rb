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
  let!(:question1) { FactoryGirl.create :question, number: 1, criterion: 'Main criterion' }
  let!(:ls_q1) { FactoryGirl.create :left_statement, title: 'left1', question: question1 }
  let!(:rs_q1) { FactoryGirl.create :right_statement, title: 'right1', question: question1 }
  let!(:question2) { FactoryGirl.create :question, number: 2, criterion: 'Irrelevant criterion' }
  let!(:ls_q2) { FactoryGirl.create :left_statement, title: 'left2', text: 'hidden text', question: question2 }
  let!(:rs_q2) { FactoryGirl.create :right_statement, title: 'right2', question: question2 }
  let!(:question3) { FactoryGirl.create :question, number: 201, sentence: 'Sentence' }

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
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_content 'user2'
      expect(page).to have_selector '.edit_user_link'
    end
  end

  it 'find all the users' do
    fill_in id: 'search_field', with: 'user'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
    end
  end

  it 'find only one coordinator' do
    fill_in id: 'search_field', with: 'coordinator2'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_content 'coordinator2'
      expect(page).to have_selector '.edit_coordinator_link'
    end
  end

  it 'find all the coordinators' do
    fill_in id: 'search_field', with: 'coordinator'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
    end
  end

  it 'find only one company' do
    fill_in id: 'search_field', with: 'company2'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 1
      expect(page).to have_content 'company2'
      expect(page).to have_selector '.edit_company_link'
    end
  end

  it 'find all the companies' do
    fill_in id: 'search_field', with: 'company'
    click_button 'search_button'
    within '.masonry_container' do
      expect(page).to have_selector ".masonry_element", count: 3
    end
  end

  it 'find one question by criterion' do
    fill_in id: 'search_field', with: 'Main'
    click_button 'search_button'
    expect(page).to have_selector '.question', count: 1
    expect(page).to have_content 'Main criterion'
    expect(page).to have_content 'left1'
    expect(page).to have_content 'right1'
  end

  it 'find all question by criterion' do
    fill_in id: 'search_field', with: 'criterion'
    click_button 'search_button'
    expect(page).to have_selector '.question', count: 2
    expect(page).to have_content 'left1'
    expect(page).to have_content 'right1'
    expect(page).to have_content 'left2'
    expect(page).to have_content 'right2'
  end

  it 'find question by sentence' do
    fill_in id: 'search_field', with: 'sentence'
    click_button 'search_button'
    expect(page).to have_selector '.question', count: 1
    expect(page).to have_content 'Sentence'
  end

  it 'find question by title of statements' do
    fill_in id: 'search_field', with: 'left'
    click_button 'search_button'
    expect(page).to have_selector '.question', count: 2
    expect(page).to have_content 'hidden text'
    expect(page).to have_content 'left1'
    expect(page).to have_content 'right1'
    expect(page).to have_content 'left2'
    expect(page).to have_content 'right2'
  end

  it 'find question by text of statements' do
    fill_in id: 'search_field', with: 'text'
    click_button 'search_button'
    expect(page).to have_selector '.question', count: 1
    expect(page).to have_content 'hidden text'
    expect(page).to have_content 'left2'
    expect(page).to have_content 'right2'
  end
end
