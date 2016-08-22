require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirect to sign in' do
      sign_out user
      get :index
      expect(response).to redirect_to(:new_user_session)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :index
      expect(response).to redirect_to(:new_info)
    end
  end

  describe 'GET #show' do
    let!(:survey) { FactoryGirl.create :survey, user: user }
    
    it 'successfully' do
      get :show, params: { id: survey.id }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to sign in' do
      sign_out user
      get :show, params: { id: survey.id }
      expect(response).to redirect_to(:new_user_session)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :show, params: { id: survey.id }
      expect(response).to redirect_to(:new_info)
    end
  end

  describe 'GET #new' do
    let(:info) { FactoryGirl.create :info, user: user }

    it 'successfully' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :new
      expect(response).to redirect_to(:new_info)
    end
  end

  describe 'POST #create' do
  end
end
