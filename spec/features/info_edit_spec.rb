require 'rails_helper'

RSpec.describe 'User update his info', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let(:info) { FactoryGirl.create :info, user: user }
  let!(:info_clone) { info.dup }

  describe 'impossible for' do
    after do
      expect(page.current_path).to eq new_user_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit edit_info_path
    end

    it 'coordinator' do
      sign_in FactoryGirl.create :coordinator
      visit edit_info_path
    end

    it 'admin' do
      sign_in FactoryGirl.create :admin
      visit edit_info_path
    end
  end

  describe 'when signed in' do
    before do
      sign_in user
      visit edit_info_path
    end

    it 'update when submit button clicked' do
      select("более 55 лет", from: 'info_age')
      click_button "Подтвердить"
      within '#messages .alert-success' do
	expect(page).to have_content "Ваши данные обновлены."
      end
      expect(page.current_path).to eq(surveys_path)
      user.reload
      expect(user.info.age).not_to eq(info_clone.age)
    end
  end
end
