require 'rails_helper'

RSpec.describe "Admin can delete coordinators", type: :feature do
  let(:admin) { FactoryGirl.create :admin }
  let!(:coordinator) { FactoryGirl.create :coordinator }

  before do
    sign_in admin
    visit admins_coordinators_path
  end

  it 'successfully' do
    expect(page).to have_selector '.coordinator'
    find('.coordinator .delete_coordinator').trigger 'click'
    within '#messages .alert-success' do
      expect(page).to have_content "Координатор удален"
    end
    expect(page).not_to have_selector '.coordinator'
  end
end
