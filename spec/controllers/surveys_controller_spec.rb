require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #index' do
    it 'redirect to sign in' do
      get :index
      expect(response).to redirect_to(:new_user_session)
    end

    it 'successfully' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
