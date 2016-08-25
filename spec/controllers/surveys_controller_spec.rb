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
      get :show, params: { id: survey.id }
      expect(response).to have_http_status(:success)
    end

    it 'fails for other user' do
      other_user = FactoryGirl.create :user
      survey = FactoryGirl.create :survey, user: other_user
      get :show, params: { id: survey.id }
      expect(response).to redirect_to(:surveys)
      expect(flash).to_not be_empty
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

  describe 'POST #create' do
    let!(:resp) { FactoryGirl.create :response, survey: survey }

    it 'successfully' do
      post :create
      expect(response).to redirect_to(edit_survey_url(assigns(:survey)))
      expect(assigns(:survey).id).to_not eq survey.id
    end

    it 'using empty survey instead creating new' do
      resp.destroy
      post :create
      expect(response).to redirect_to(edit_survey_url(assigns(:survey)))
      expect(assigns(:survey).id).to eq survey.id
    end

    it 'redirect to sign in' do
      sign_out user
      post :create
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(:new_user_session)
    end
  end

  describe 'GET #edit' do
    it 'successfully' do
      get :edit, params: { id: survey.id }
      expect(response).to have_http_status(:success)
    end

    it 'redirect to info#new' do
      user.info = nil
      get :edit, params: { id: survey.id }
      expect(response).to redirect_to(:new_info)
    end
  end
end
