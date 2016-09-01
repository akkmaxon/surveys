require 'rails_helper'

RSpec.describe 'User update his info', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let(:info) { FactoryGirl.create :info, user: user }
  let!(:info_clone) { info.dup }

  before do
    login_as user
    visit edit_info_path
  end

  it 'nothing happen if only touch field' do
    find("#info_age_2").trigger 'click'
    user.reload
    expect(user.info.age).to eq(info_clone.age)
  end

  it 'update when submit button clicked' do
    find("#info_age_2").trigger 'click'
    click_button 'submit_info'
    expect(page).to have_selector('#messages .alert-success')
    expect(page.current_path).to eq(surveys_path)
    user.reload
    expect(user.info.age).not_to eq(info_clone.age)
  end
end
