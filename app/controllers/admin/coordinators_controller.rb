class Admin::CoordinatorsController < Admin::ApplicationController
  before_action :set_coordinator, only: [:update, :destroy]
  before_action :set_coordinators, except: [:destroy]

  def index
    @coordinators = Coordinator.all
    @coordinator = Coordinator.new
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    if @coordinator.save
      flash[:notice] = "Координатор создан."
      redirect_back(fallback_location: admin_companies_url)
    else
      render :index
    end
  end

  def update
    if @coordinator.update(coordinator_params)
      flash[:notice] = "Координатор изменен."
      redirect_back(fallback_location: admin_companies_url)
    else
      render :index
    end
  end

  def destroy
    @coordinator.destroy
    flash[:notice] = "Координатор удален."
    redirect_back(fallback_location: admin_companies_url)
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:login, :password)
  end

  def set_coordinator
    @coordinator = Coordinator.find(params[:id])
  end

  def set_coordinators
    @coordinators = Coordinator.order(updated_at: :desc)
  end
end
