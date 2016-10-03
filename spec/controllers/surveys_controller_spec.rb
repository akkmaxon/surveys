require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { FactoryGirl.create :survey, user: user }

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
    it 'successfully' do
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to have_http_status(:success)
    end

    it 'fails for other user' do
      other_user = FactoryGirl.create :user
      survey = FactoryGirl.create :survey, user: other_user
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:surveys)
      expect(flash).to_not be_empty
    end

    it 'redirect to sign in' do
      sign_out user
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:new_user_session)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :show, params: { id: (survey.id + CRYPT_SURVEY).to_s(36) }
      expect(response).to redirect_to(:new_info)
    end
  end

  describe 'POST #create' do
    let!(:question) { FactoryGirl.create :question }
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
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(:new_user_session)
    end

    it 'redirect to info#new' do
      user.info = nil
      post :create
      expect(response).to redirect_to(:new_info)
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
    end
  end

  describe 'PUT #update' do
    it 'remotely' do
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to have_http_status(:success)
      expect(response).to_not redirect_to(:surveys)
    end

    it 'with redirect to surveys' do
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to have_http_status(:success)
      expect(response).to_not redirect_to(:surveys)
    end

    it 'redirect to sign in' do
      sign_out user
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to redirect_to(:new_user_session)
    end

    it 'redirect to info#new' do
      user.info = nil
      put :update, params: { id: (survey.id + CRYPT_SURVEY).to_s(36), survey: { user_agreement: 'i agree' } }
      expect(response).to redirect_to(:new_info)
    end
  end
end
