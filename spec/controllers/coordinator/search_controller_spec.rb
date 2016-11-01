require 'rails_helper'

RSpec.describe Coordinator::SearchController, type: :controller do
  describe 'GET #search' do
    let!(:coordinator) { FactoryGirl.create :coordinator }

    it 'successfully' do
      sign_in coordinator
      get :search, params: { q: 'find me' }
      expect(response).to render_template(:search)
    end

    it 'redirect when not signed in' do
      get :search, params: { q: 'find me' }
      expect(response).to redirect_to(:new_coordinator_session)
    end
  end
end
