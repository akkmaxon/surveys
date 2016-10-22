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
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end

    it 'redirect to #edit if info present' do
      info.save
      get :new
      expect(response).to redirect_to(:edit_info)
    end
  end

  describe 'POST #create' do
    let(:info_params) { FactoryGirl.attributes_for(:info) }

    it 'successfully' do
      post :create, params: { info: info_params }
      expect(response).to redirect_to "/surveys/#{(user.surveys.first.id + CRYPT_SURVEY).to_s(36)}/take"
      expect(flash[:notice]).to eq("Спасибо, теперь Вы можете пройти тест.")
    end

    it 'rerender new' do
      info_params.update(gender: "",
			 experience: "",
			 age: "",
			 workplace_number: "",
			 work_position: "",
			 company: "")
      post :create, params: { info: info_params }
      expect(response).to render_template(:new)
      expect(flash[:notice]).to be nil
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
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end

    it 'redirect to sign in' do
      sign_out user
      get :edit
      expect(response).to redirect_to(:new_user_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'PUT #update' do
    let(:info_params) { FactoryGirl.attributes_for(:info) }

    before do
      info.save!
    end

    it 'successfully' do
      put :update, params: { info: info_params }
      expect(response).to redirect_to(:surveys)
      expect(flash[:notice]).to eq("Ваши данные обновлены.")
    end

    it 'rerender edit' do
      info_params.update(gender: "",
			 experience: "",
			 age: "",
			 workplace_number: "",
			 work_position: "",
			 company: "")
      put :update, params: { info: info_params }
      expect(response).to render_template(:edit)
      expect(flash[:notice]).to be nil
    end
  end
end
