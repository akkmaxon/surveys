require 'rails_helper'

RSpec.describe Coordinators::CompaniesController, type: :controller do
  let(:coordinator) { FactoryGirl.create :coordinator }

  before do
    sign_in coordinator
  end


  describe "GET #index" do
    it "returns http success" do
      get :index
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
