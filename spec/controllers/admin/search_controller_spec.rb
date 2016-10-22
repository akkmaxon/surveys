require 'rails_helper'

RSpec.describe Admin::SearchController, type: :controller do
  describe 'GET #search' do
    let!(:admin) { FactoryGirl.create :admin }

    it 'successfully' do
      sign_in admin
      get :search
      expect(response).to render_template(:search)
    end

    it 'redirect to sign in' do
      get :search
      expect(response).to redirect_to(:new_admin_session)
    end
  end
end
