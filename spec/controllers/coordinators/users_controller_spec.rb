require 'rails_helper'

RSpec.describe Coordinators::UsersController, type: :controller do
  describe 'GET #index' do
    let!(:coordinator) { FactoryGirl.create :coordinator }

    it 'successfully' do
      sign_in coordinator
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirect when not logged in' do
      get :index
      expect(response).to redirect_to(:new_coordinator_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
