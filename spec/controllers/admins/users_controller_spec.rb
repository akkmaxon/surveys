require 'rails_helper'

RSpec.describe Admins::UsersController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }
  let!(:user) { FactoryGirl.create :user }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirect to sign in' do
      sign_out :admin
      get :index
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'GET #show' do
    it 'redirect to sign in' do
      sign_out :admin
      get :show, params: { id: user.login }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'POST #create' do
    it 'successfully' do
      post :create, params: { user: { login: "Login", password: "password" } }
      expect(response).to redirect_to(:admins_users)
      expect(flash[:notice]).to eq("Респондент создан.")
    end

    it 'fails when empty params' do
      post :create, params: { user: { login: "", password: "" } }
      expect(response).to render_template(:index)
      expect(flash).to be_empty
    end

    it 'redirect to sign in' do
      sign_out :admin
      post :create, params: { user: { login: "Login", password: "password" } }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'PUT #update' do
    it 'successfully' do
      put :update, params: { id: user.login, user: { login: "New Login", password: "newpassword" } }
      expect(response).to redirect_to(:admins_users)
      expect(flash[:notice]).to eq("Респондент изменен.")
    end

    it 'fails when empty params' do
      put :update, params: { id: user.login, user: { login: "", password: "" } }
      expect(response).to render_template(:index)
      expect(flash).to be_empty
    end

    it 'redirect to sign in' do
      sign_out :admin
      put :update, params: { id: user.login, user: { login: "New Login", password: "newpassword" } }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
