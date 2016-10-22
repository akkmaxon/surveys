require 'rails_helper'

RSpec.describe Admin::CompaniesController, type: :controller do
  let(:admin) { FactoryGirl.create :admin }

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
      post :create, params: { company: { name: 'Company' } }
      expect(response).to redirect_to(:admin_companies)
      expect(flash[:notice]).to eq("Список компаний расширен.")
    end

    it 'fails without name' do
      post :create, params: { company: { name: '' } }
      expect(response).to redirect_to(:admin_companies)
      expect(flash[:alert]).to eq("Для добавления компании укажите ее имя.")
    end

    it 'redirect to sign in' do
      sign_out admin
      post :create, params: { company: { name: 'Company' } }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'PUT #update' do
    let!(:company) { FactoryGirl.create :company }

    it 'successfully' do
      put :update, params: { id: company.id, company: { name: 'New Name' } }
      expect(response).to redirect_to(:admin_companies)
      expect(flash[:notice]).to eq("Список компаний обновлен.")
    end

    it 'fails without name' do
      put :update, params: { id: company.id, company: { name: ''} }
      expect(response).to redirect_to(:admin_companies)
      expect(flash[:alert]).to eq("Необходимо указать новое имя компании.")
    end

     it 'redirect to sign in' do
      sign_out admin
      put :update, params: { id: company.id, company: { name: 'New Name' } }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end

  describe 'DELETE #destroy' do
    let!(:company) { FactoryGirl.create :company }

    it 'successfully' do
      delete :destroy, params: { id: company.id }
      expect(response).to redirect_to(:admin_companies)
      expect(flash[:notice]).to eq("Компания удалена.")
    end

    it 'redirect to sign in' do
      sign_out admin
      delete :destroy, params: { id: company.id }
      expect(response).to redirect_to(:new_admin_session)
      expect(flash[:alert]).to eq("Войдите, пожалуйста, в систему.")
    end
  end
end
