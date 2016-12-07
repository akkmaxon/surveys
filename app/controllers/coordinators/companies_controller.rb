class Coordinators::CompaniesController < Coordinators::ApplicationController
  def index
    @companies = Company.all
  end
end
