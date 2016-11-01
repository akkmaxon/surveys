require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }
  let!(:question) { FactoryGirl.create :question }
  let!(:lst) { FactoryGirl.create :left_statement, question: question }
  let!(:rst) { FactoryGirl.create :right_statement, question: question }
  let(:question_params) do
    { question: FactoryGirl.attributes_for(:question),
      left_title: FactoryGirl.attributes_for(:left_statement)[:title],
      left_text: FactoryGirl.attributes_for(:left_statement)[:text],
      right_title: FactoryGirl.attributes_for(:right_statement)[:title],
      right_text: FactoryGirl.attributes_for(:right_statement)[:text] }
  end

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'successfully' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'redirect to sign in' do
      sign_out admin
      get :index
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'POST #create' do
    it 'successfully' do
      post :create, params: question_params
      expect(response).to redirect_to(:admin_questions)
      expect(flash[:notice]).to eq("Вопрос создан.")
    end

    it 'redirect to sign in' do
      sign_out admin
      post :create, params: question_params
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'PUT #update' do
    it 'successfully' do
      put :update, params: question_params.merge({ id: question.id })
      expect(response).to redirect_to(:admin_questions)
      expect(flash[:notice]).to eq("Вопрос обновлен.")
    end

    it 'redirect to sign in' do
      sign_out admin
      put :update, params: question_params.merge({ id: question.id })
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'DELETE #destroy' do
    it 'successfully' do
      delete :destroy, params: { id: question.id }
      expect(response).to redirect_to(:admin_questions)
      expect(flash[:notice]).to eq("Вопрос удален.")
    end

    it 'redirect to sign in' do
      sign_out admin
      delete :destroy, params: { id: question.id }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
