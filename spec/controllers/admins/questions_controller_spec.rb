require 'rails_helper'

RSpec.describe Admins::QuestionsController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }
  let!(:question) do
    Question.create! opinion_subject: "Я",
      audience: "Менеджмент",
      number: 1,
      title: "Title",
      criterion: "Criterion",
      criterion_type: "Вовлеченность"
  end
  let!(:lst) { LeftStatement.create! title: "Title", text: "Text", question: question }
  let!(:rst) { RightStatement.create! title: "Title", text: "Text", question: question }
  let(:question_params) do
    { question: {
	title: "Title",
	number: 10,
	audience: "Менеджмент",
	opinion_subject: "Я",
	criterion: "Criterion",
	criterion_type: "Вовлеченность",
	sentence: ""
      },
      left_title: "New Left Title",
      left_text: "New Left Text",
      right_title: "New Right Title",
      right_text: "New Right Text" }
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
      expect(response).to redirect_to(:admins_questions)
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
      expect(response).to redirect_to(:admins_questions)
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
      expect(response).to redirect_to(:admins_questions)
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
