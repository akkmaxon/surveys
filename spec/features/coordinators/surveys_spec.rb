require 'rails_helper'

RSpec.describe 'Coordinator can view surveys', type: :feature do
  let(:coordinator) { FactoryGirl.create :coordinator }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_coordinator_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit coordinators_surveys_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create(:user)
      visit coordinators_surveys_path
    end

    it 'admin' do
      sign_in FactoryGirl.create(:admin)
      visit coordinators_surveys_path
    end
  end

  describe 'successfully' do
    let(:user) { FactoryGirl.create(:user, login: 'user123') }

    before do
      2.times { Survey.create! user: user, completed: true }
      sign_in coordinator
    end

    it 'without filters' do
      visit coordinators_surveys_path
      within '.masonry_container' do
	expect(page).to have_selector '.survey', count: 2
	expect(page).to have_selector 'a.show_report', count: 2
      end
    end

    context 'for specific user' do
      let(:other_user) { FactoryGirl.create(:user, login: 'Specific User') }

      before do
	FactoryGirl.create(:info, user: other_user)
      end

      it 'with completed survey' do
	Survey.create!(user: other_user, completed: true)
	visit coordinators_users_path
	first('.show_user_surveys').trigger('click')
	expect(page.current_path).to eq(coordinators_surveys_path)
	expect(page).to have_content("Опросы (#{other_user.login}) 1")
	expect(page).to have_selector('.masonry_container .survey', count: 1)
      end

      it 'without completed surveys' do
	visit coordinators_users_path
	first('.show_user_surveys').trigger('click')
	expect(page.current_path).to eq(coordinators_surveys_path)
	expect(page).to have_content("Опросы (#{other_user.login}) 0")
	expect(page).to have_selector('.masonry_container .survey', count: 0)
      end
    end
  end
end
