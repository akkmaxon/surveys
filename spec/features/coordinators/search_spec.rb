require 'rails_helper'

RSpec.describe 'Coordinator can search and', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }
  ### users
  let!(:user1) { FactoryGirl.create :user, login: 'user1' }
  let!(:user2) { FactoryGirl.create :user, login: 'user2' }
  let!(:user3) { FactoryGirl.create :user, login: 'user3' }
  ### infos
  let!(:info1) { FactoryGirl.create :info, user: user1 }
  let!(:info2) { FactoryGirl.create :info, user: user2 }
  let!(:info3) { FactoryGirl.create :info, user: user3 }
  ### surveys
  let!(:survey1) { FactoryGirl.create :survey, id: 11, user: user1, completed: true, user_email: 'first@email.com', user_agreement: 'not agree', audience: "Менеджмент" }
  let!(:survey2) { FactoryGirl.create :survey, id: 12, user: user2, completed: true, user_email: 'second@email.com', user_agreement: 'agree', audience: "Менеджмент" }
  let!(:survey3) { FactoryGirl.create :survey, id: 13, user: user3, completed: true, user_email: 'third@email.com', user_agreement: 'partially agree', audience: "Рабочая специальность" }

  before do
    sign_in coordinator
    visit coordinators_root_path
  end

  it 'redirect proper page' do
    fill_in id: 'search_field', with: 'abcdef'
    click_button 'search_button'
    expect(page.current_path).to eq coordinators_search_path
  end

  context 'find nothing when' do
    it 'query is empty' do
      fill_in id: 'search_field', with: ''
      click_button 'search_button'
      expect(page).to have_content "найти не удалось"
    end

    it 'query is valid' do
      fill_in id: 'search_field', with: 'abcdef'
      click_button 'search_button'
      expect(page).to have_content "найти не удалось"
    end
  end

  context 'find users' do
    it 'one by login' do
      fill_in id: 'search_field', with: 'user2'
      click_button 'search_button'
      find('#coord_users_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_content 'user2'
	expect(page).to have_selector '.show_surveys', count: 1
      end
    end

    it 'all by login' do
      fill_in id: 'search_field', with: 'user'
      click_button 'search_button'
      find('#coord_users_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
      end
    end

    it 'one by gender' do
      info1.update gender: "женский"
      fill_in id: 'search_field', with: "женский"
      click_button 'search_button'
      find('#coord_users_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_content 'user1'
	expect(page).to have_selector '.show_surveys', count: 1
      end
    end

    it 'all by gender' do
      fill_in id: 'search_field', with: "мужской"
      click_button 'search_button'
      find('#coord_users_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
	expect(page).to have_content 'user1'
	expect(page).to have_content 'user2'
	expect(page).to have_content 'user3'
      end
    end

    it 'by company' do
      info1.update company: 'CompanyOne'
      fill_in id: 'search_field', with: 'Company'
      click_button 'search_button'
      find('#coord_users_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_content 'user1'
      end
    end
  end

  context 'find surveys' do
    it 'by id' do
      fill_in id: 'search_field', with: '12'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user2'
      end
    end

    it 'one by user email' do
      fill_in id: 'search_field', with: 'first'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'first@email.com'
      end
    end

    it 'all by user email' do
      fill_in id: 'search_field', with: '@email'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
	expect(page).to have_selector '.show_survey', count: 3
	expect(page).to have_content 'first@email.com'
	expect(page).to have_content 'second@email.com'
	expect(page).to have_content 'third@email.com'
      end
    end

    it 'one by user agreement' do
      fill_in id: 'search_field', with: 'partially agree'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user3'
      end
    end

    it 'all by user agreement' do
      fill_in id: 'search_field', with: 'agree'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
	expect(page).to have_selector '.show_survey', count: 3
	expect(page).to have_content 'user1'
	expect(page).to have_content 'user2'
	expect(page).to have_content 'user3'
      end
    end

    it 'one by user login' do
      fill_in id: 'search_field', with: 'user1'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user1'
      end
    end

    it 'all by user login' do
      fill_in id: 'search_field', with: 'user'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
	expect(page).to have_selector '.show_survey', count: 3
	expect(page).to have_content 'user1'
	expect(page).to have_content 'user2'
	expect(page).to have_content 'user3'
      end
    end

    it 'one by gender' do
      info1.update gender: "женский"
      fill_in id: 'search_field', with: "женский"
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user1'
      end
    end

    it 'all by gender' do
      fill_in id: 'search_field', with: "мужской"
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 3
	expect(page).to have_selector '.show_survey', count: 3
	expect(page).to have_content 'user1'
	expect(page).to have_content 'user2'
	expect(page).to have_content 'user3'
      end
    end

    it 'one by company' do
      info1.update company: 'CompanyOne'
      fill_in id: 'search_field', with: 'Company'
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user1'
      end
    end

    it 'by audience' do
      fill_in id: 'search_field', with: "Рабочая"
      click_button 'search_button'
      find('#coord_surveys_search_results').trigger 'click'
      within '.masonry_container' do
	expect(page).to have_selector ".masonry_element", count: 1
	expect(page).to have_selector '.show_survey', count: 1
	expect(page).to have_content 'user3'
      end
    end
  end
end
