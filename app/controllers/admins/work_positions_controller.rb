class Admins::WorkPositionsController < Admins::ApplicationController
  before_action :set_work_position, only: [:update, :destroy]

  def index
    @work_positions = WorkPosition.all
    @new_wp = WorkPosition.new
  end

  def create
    @work_position = WorkPosition.new(wp_params)
    if @work_position.save
      flash[:notice] = "Должность добавлена"
    else
      flash[:alert] = "Требуется указать название"
    end
    redirect_to admins_work_positions_path
  end

  def update
    if @work_position.update(wp_params)
      flash[:notice] = "Должность обновлена"
    else
      flash[:alert] = "Требуется указать название"
    end
    redirect_to admins_work_positions_path
  end

  def destroy
    @work_position.destroy
    flash[:notice] = "Должность удалена"
    redirect_to admins_work_positions_path
  end

  private

  def wp_params
    params.require(:work_position).permit(:title)
  end

  def set_work_position
    @work_position = WorkPosition.find(params[:id])
  end
end
