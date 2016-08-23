class InfosController < ApplicationController
  before_action :check_for_empty_info, only: [:edit]
  before_action :find_info, only: [:edit, :update]

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(info_params.merge user_id: current_user.id)
    if @info.save
      flash[:notice] = 'Now you can take a survey.'
      redirect_to surveys_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @info.update(info_params)
      flash[:notice] = 'Information about yourself has been updated.'
      redirect_to surveys_url
    else
      render :edit
    end
  end

  private

  def info_params
    params.require(:info).permit(:gender,
				 :experience,
				 :age,
				 :workplace_number,
				 :work_position)
  end

  def find_info
    @info = Info.find(current_user.info.id)
  end

end
