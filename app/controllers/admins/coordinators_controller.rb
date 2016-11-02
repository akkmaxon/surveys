class Admins::CoordinatorsController < Admins::ApplicationController
  before_action :set_coordinator, only: [:show, :update, :destroy]
  before_action :set_coordinators, except: [:destroy]

  def index
    @coordinators = Coordinator.all
    @coordinator = Coordinator.new
  end

  def show
    render pdf: @coordinator.login
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    if @coordinator.save
      session[:coordinator_credentials] = coordinator_params
      flash[:notice] = "Координатор создан."
      redirect_to admins_coordinators_url
    else
      render :index
    end
  end

  def update
    if @coordinator.update(coordinator_params)
      session[:coordinator_credentials] = coordinator_params
      flash[:notice] = "Координатор изменен."
      redirect_to admins_coordinators_url
    else
      render :index
    end
  end

  def destroy
    @coordinator.destroy
    flash[:notice] = "Координатор удален."
    redirect_to admins_coordinators_url
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
