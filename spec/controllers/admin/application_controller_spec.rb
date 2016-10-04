require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }

  before do
    sign_in admin
  end 

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:redirect)
    end
  end

end
