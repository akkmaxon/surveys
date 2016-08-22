require 'rails_helper'

RSpec.describe InfosController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before do
    sign_in user
  end

  describe 'POST #create' do
  end

  describe 'GET #edit' do
    let!(:info) { FactoryGirl.create :info, user: user }

    it 'successfully init @info' do
      get :edit
      expect(response).to have_http_status(:success)
    end

    it 'redirect to new info' do 
      user.info = nil
      get :edit
      expect(response).to redirect_to(:new_info)
    end

    it 'redirect to sign in' do
      sign_out user
      get :edit
      expect(response).to redirect_to(:new_user_session)
    end
  end

  describe 'PATCH #update' do
  end
end
