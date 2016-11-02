class Admins::CompaniesController < Admins::ApplicationController
  before_action :set_company, only: [:update, :destroy]

  def index
    @companies = Company.order(updated_at: :desc)
    @new_company = Company.new
  end

  def create
    @new_company = Company.new(company_params)
    if @new_company.save
      flash[:notice] = "Список компаний расширен."
    else
      flash[:alert] = "Для добавления компании укажите ее имя."
    end
    redirect_to admins_companies_url
  end

  def update
    if @company.update(company_params)
      flash[:notice] = "Список компаний обновлен."
    else
      flash[:alert] = "Необходимо указать новое имя компании."
    end
    redirect_to admins_companies_url
  end

  def destroy
    @company.destroy
    flash[:notice] = "Компания удалена."
    redirect_to admins_companies_url
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
