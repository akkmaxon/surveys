require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { Survey.create! user: user }

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
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end

    it 'redirect to info#new' do
      user.info = nil
      get :index
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end
  end

  describe 'GET #show' do
    it 'successfully' do
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to have_http_status(:success)
    end

    it 'fails for other user' do
      other_user = FactoryGirl.create :user
      survey = Survey.create! user: other_user
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:surveys)
      expect(flash[:alert]).to eq("Вы не можете видеть результаты других пользователей")
    end

    it 'redirect to sign in' do
      sign_out user
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:new_user_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end

    it 'redirect to info#new' do
      user.info = nil
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end
  end

  describe 'POST #create' do
    fixtures :questions
    
    let!(:question) { questions(:question1_management) }
    let!(:resp) { FactoryGirl.create :response, survey: survey, question_number: question.number }

    it 'successfully' do
      survey.update completed: true
      post :create
      expect(response).to redirect_to(take_survey_url(assigns(:survey)))
      expect(assigns(:survey).id).to_not eq(survey.id)
    end

    it 'using empty survey instead creating new' do
      post :create
      expect(response).to redirect_to(take_survey_url(assigns(:survey)))
      expect(assigns(:survey).id).to eq(survey.id)
    end

    it 'redirect to sign in' do
      sign_out user
      post :create
      expect(response).to redirect_to(:new_user_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end

    it 'redirect to info#new' do
      user.info = nil
      post :create
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end
  end

  describe 'GET #take' do
    it 'successfully' do
      get :take, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :take, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end
  end

  describe 'PUT #update' do
    it 'after completion' do
      [{user_agreement: 'i agree'}, {user_email: 'my@email.com'}].each do |key|
	put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: key }
	expect(response).to have_http_status(:success)
	expect(response).to_not redirect_to(:surveys)
	expect(flash).to be_empty
      end
    end

    it 'redirect to sign in' do
      sign_out user
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to redirect_to(:new_user_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end

    it 'redirect to info#new' do
      user.info = nil
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to redirect_to(:new_info)
      expect(flash[:notice]).to eq("Перед началом работы заполните, пожалуйста, некоторые данные о себе.")
    end
  end
end
