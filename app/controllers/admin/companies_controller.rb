class Admin::CompaniesController < Admin::ApplicationController
  def index
    @companies = Company.order(updated_at: :desc).pluck(:name)
    @new_company = Company.new
  end

  def create
    @new_company = Company.new(company_params)
    if @new_company.save
      flash[:notice] = "Список компаний расширен."
    else
      flash[:alert] = "Невозможно создать компанию без названия."
    end
    redirect_to admin_companies_url
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
