require 'rails_helper'

RSpec.describe InfosController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let(:info) { FactoryGirl.build :info, user: user }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'successfully' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'redirect to sign in' do
      sign_out user
      get :new
      expect(response).to redirect_to(:new_user_session)
    end
  end

  describe 'POST #create' do
    let(:info_params) { FactoryGirl.attributes_for(:info) }

    it 'successfully' do
      post :create, params: { info: info_params }
      expect(response).to redirect_to(:surveys) 
      expect(flash[:notice]).to_not eq nil
    end

    it 'rerender new' do
      info_params.update(gender: "",
			 experience: "",
			 age: "",
			 workplace_number: "",
			 work_position: "")
      post :create, params: { info: info_params }
      expect(response).to render_template(:new)
      expect(flash[:notice]).to eq nil
    end
  end

  describe 'GET #edit' do
    it 'successfully' do
      info.update(age: '100 years')
      get :edit
      expect(response).to have_http_status(:success)
      expect(assigns(:info).age).to eq('100 years')
    end

    it 'redirect to new info' do 
      get :edit
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to_not eq nil
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
