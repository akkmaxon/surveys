require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
  let(:user) { FactoryGirl.create :user }
  let!(:info) { FactoryGirl.create :info, user: user }
  let!(:survey) { FactoryGirl.create :survey, user: user }

  before do
    sign_in user
  end

  describe 'POST #create' do
    let(:resp) { FactoryGirl.attributes_for :response, answer: 3 }
    context 'successfully' do
      it 'create new response' do
	expect(Response.count).to eq 0
	post :create, xhr: true, params: { survey_id: survey.id, response: resp }
	expect(response).to have_http_status(:success)
	expect(Response.count).to eq 1
      end

      it 'update response' do
	Response.create! resp.merge(survey_id: survey.id)
	expect(Response.count).to eq 1
	expect(Response.first.answer).to eq("3")
	resp[:answer] = 1000
	post :create, xhr: true, params: { survey_id: survey.id, response: resp }
	expect(response).to have_http_status(:success)
	expect(Response.count).to eq 1
	expect(Response.first.answer).to eq("1000")
      end
    end

    context 'fails' do
      it 'empty parameters' do
	expect {
	  post :create, xhr: true, params: { survey_id: survey.id, response: { question_number: nil, answer: ''} }
	}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'redirect to sign in' do
	sign_out user
	post :create, params: { survey_id: survey.id, response: resp }
	expect(response).to redirect_to(:new_user_session)
	expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
      end	

      it 'survey is absent' do
	survey.destroy
	expect {
	  post :create, params: { survey_id: survey.id, response: resp }
	}.to raise_error(ActiveRecord::InvalidForeignKey)
      end
    end
  end
end
