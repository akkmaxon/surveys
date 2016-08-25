require 'rails_helper'

RSpec.describe 'Work with surveys/edit', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:question_one) { FactoryGirl.create :question }
  let!(:question_two) { FactoryGirl.create :question }
  let!(:question_three) { FactoryGirl.create :question }

  before do
    login_as user
    visit root_path
    click_link 'new_survey'
  end

  it 'Page layout before' do
    expect(page).to have_selector '.response', count: 3
    expect(page).to have_selector '.progress'
    expect(page).to have_selector '#finish_survey'
    save_page
  end

  it 'Page layout after' do
  end
end
