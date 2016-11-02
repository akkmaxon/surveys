require 'rails_helper'

RSpec.describe Admins::ApplicationController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
  end 

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to redirect_to(:admins_users)
    end

    it 'redirect when not signed in' do
      sign_out admin
      get :index
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
