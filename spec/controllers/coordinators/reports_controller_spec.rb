require 'rails_helper'

RSpec.describe Coordinators::ReportsController, type: :controller do
  let(:coordinator) { FactoryGirl.create :coordinator }
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { FactoryGirl.create :survey, user: user, completed: true }

  before do
    sign_in coordinator
  end

  describe "GET #index" do
    it 'with survey in params' do
      get :index, params: { survey: survey.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'with user in params' do
      get :index, params: { user: user.login }
      expect(response).to have_http_status(:success)
    end

    it 'with company in params' do
      get :index, params: { company: info.company }
      expect(response).to have_http_status(:success)
    end

    it 'with work_position in params' do
      get :index, params: { work_position: info.work_position }
      expect(response).to have_http_status(:success)
    end

    it 'redirect when not signed in' do
      sign_out coordinator
      get :index
      expect(response).to redirect_to(:new_coordinator_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
