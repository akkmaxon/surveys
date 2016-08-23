class InfosController < ApplicationController
  before_action :check_for_empty_info, only: [:edit]

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(info_params.merge user_id: current_user.id)
    if @info.save
      flash[:notice] = 'Information about yourself has been created.'
      redirect_to surveys_url
    else
      render :new
    end
  end

  def edit
    @info = Info.find(current_user.info.id)
  end

  private

  def info_params
    params.require(:info).permit(:gender,
				 :experience,
				 :age,
				 :workplace_number,
				 :work_position)
  end
end
