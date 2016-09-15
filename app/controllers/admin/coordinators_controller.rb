class Admin::CoordinatorsController < Admin::ApplicationController
  before_action :set_coordinator, only: [:destroy]

  def index
    @coordinators = Coordinator.all
    @coordinator = Coordinator.new
  end

  def destroy
    @coordinator.destroy
    flash[:notice] = "Координатор удален."
    redirect_back(fallback_location: admin_companies_url)
  end

  private

  def set_coordinator
    @coordinator = Coordinator.find(params[:id])
  end
end
