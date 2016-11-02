require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #about' do
    it 'not signed in user' do
      get :about
      expect(response).to have_http_status(:success)
    end

    it 'sign in user' do
      sign_in FactoryGirl.create(:user)
      get :about
      expect(response).to redirect_to(:surveys)
    end

    it 'sign in admin' do
      sign_in FactoryGirl.create(:admin)
      get :about
      expect(response).to redirect_to(:admins_root)
    end

    it 'sign in coordinator' do
      sign_in FactoryGirl.create(:coordinator)
      get :about
      expect(response).to redirect_to(:coordinators_root)
    end
  end
end
