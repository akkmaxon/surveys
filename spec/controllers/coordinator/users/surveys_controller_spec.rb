require 'rails_helper'

RSpec.describe Coordinator::Users::SurveysController, type: :controller do
  let(:coordinator) { FactoryGirl.create :coordinator }
  let!(:user) { FactoryGirl.create :user }
  let!(:survey) { FactoryGirl.create :survey, user: user }

  before do
    sign_in coordinator
  end

  describe 'GET #index' do
    it 'successfully' do
      get :index, params: { user_id: user.login }
      expect(response).to have_http_status(:success)
    end

    it 'redirect when not signed in' do
      sign_out coordinator
      get :index, params: { user_id: user.login }
      expect(response).to redirect_to(:new_coordinator_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'GET #show' do
    it 'successfully' do
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), user_id: user.login }
      expect(response).to have_http_status(:success)
    end

    it 'get not existing survey' do
      get :show, params: { id: (survey.id + CRYPT_SURVEY * 2).to_s(36), user_id: user.login }
      expect(response).to redirect_to(:coordinator_surveys)
      expect(flash[:alert]).to include("не существует")
    end

    it 'redirect when not signed in' do
      sign_out coordinator
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), user_id: user.login }
      expect(response).to redirect_to(:new_coordinator_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
