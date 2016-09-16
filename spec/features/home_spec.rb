require 'rails_helper'

RSpec.describe 'Behaviour of home controller', type: :feature do
  it 'good render about page for unsigned in user' do
    visit root_path
    expect(page.current_path).to eq root_path
    within 'header' do
      expect(page).to have_content "Самооценка"
      expect(page).to have_content "Вход"
    end
  end

  it 'redirect for admin' do
    sign_in FactoryGirl.create :admin
    visit root_path
    expect(page.current_path).to eq admin_root_path
    within 'header' do
      expect(page).to have_content "Панель"
      expect(page).to have_content "Координаторы"
      expect(page).to have_content "Вопросы"
      expect(page).to have_content "Выход"
    end
  end

  it 'redirect for coordinator' do
    sign_in FactoryGirl.create :coordinator
    visit root_path
    expect(page.current_path).to eq coordinator_root_path
    within 'header' do
      expect(page).to have_content "Панель"
      expect(page).to have_content "Опросы"
      expect(page).to have_content "Респонденты"
      expect(page).to have_content "Выход"
    end
  end

  it 'redirect for signed in user' do
    sign_in FactoryGirl.create :user
    visit root_path
    expect(page.current_path).to eq new_info_path
    within 'header' do
      expect(page).to have_content "Новый опрос"
      expect(page).to have_content "о себе"
      expect(page).to have_content "Выход"
    end
  end
end
