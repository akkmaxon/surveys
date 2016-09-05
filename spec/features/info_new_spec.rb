require 'rails_helper'

RSpec.describe 'User create info about himself', type: :feature do
  let(:user) { FactoryGirl.create :user }
  let!(:company1) { FactoryGirl.create :company, id: 1 }
  let!(:company2) { FactoryGirl.create :company, id: 2 }

  before do
    login_as user
    visit surveys_path
  end

  it 'check good redirect' do
    expect(page).to have_selector 'form.new_info'
    expect(page).to have_selector '#messages .alert'
    click_link 'new_survey'
    expect(page).to have_selector 'form.new_info'
  end

  it 'do not create new survey when empty' do
    click_link 'new_survey'
    expect(Survey.count).to eq 0
  end

  it 'create info with all fields' do
    %w[gender experience age workplace_number work_position company].each do |input|
      find("#info_#{input}_1").trigger 'click'
    end
    click_button "submit_info"
    within '#messages .alert-success' do
      expect(page).to have_content "Спасибо, теперь Вы можете пройти тест."
    end
    expect(page.current_path).to eq(surveys_path)
    user.reload
    expect(user.info).not_to be_nil
  end

  it 'errors when not all fields are filled' do
    %w[gender experience age workplace_number work_position company].each do |input|
      visit new_info_path
      find("#info_#{input}_1").trigger 'click'
      click_button "submit_info"
      within '#error_explanation' do
	expect(page).to have_selector 'ul li', count: 5
      end
    end
    user.reload
    expect(user.info).to be_nil
  end

  context 'companies not defined by admin' do
    before do
      company1.destroy
      company2.destroy
      visit new_info_path
    end

    it 'page layout' do 
      expect(page).not_to have_selector '#info_company_1'
      expect(page).not_to have_selector '#info_company_2'
    end

    it 'data from user' do
      %w[gender experience age workplace_number work_position].each do |input|
	find("#info_#{input}_1").trigger 'click'
      end
      click_button 'submit_info'
      expect(page.current_path).to eq(surveys_path)
      user.reload
      expect(user.info.company).to eq "нет ответа"
    end
  end

  context 'only one company' do
    before do
      company2.destroy
      visit new_info_path
    end

    it 'page layout' do
      expect(page).not_to have_selector '#info_company_1'
    end

    it 'data from user' do
      %w[gender experience age workplace_number work_position].each do |input|
	find("#info_#{input}_1").trigger 'click'
      end
      click_button 'submit_info'
      expect(page.current_path).to eq(surveys_path)
      user.reload
      expect(user.info.company).to eq(company1.name)
    end
  end
end
