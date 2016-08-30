require 'rails_helper'

RSpec.describe 'User create info about himself', type: :feature do
  let(:user) { FactoryGirl.create :user }

  before do
    login_as user
    visit surveys_path
  end

  it 'check good redirect' do
    expect(page).to have_selector 'form.new_info'
    expect(page).to have_selector '#messages .alert'
  end

  it 'with all fields' do
    %w[gender experience age workplace_number work_position company].each do |input|
      choose id: "info_#{input}_1"
    end
    click_button "submit_info"
    expect(page).to have_selector '#messages .alert-success'
    expect(page.current_path).to eq(surveys_path)
  end

  it 'allowed to create full info only' do
    %w[gender experience age workplace_number work_position company].each do |input|
      visit new_info_path
      choose id: "info_#{input}_1"
      click_button "submit_info"
      expect(page).to have_selector '#error_explanation'
    end
  end
end
