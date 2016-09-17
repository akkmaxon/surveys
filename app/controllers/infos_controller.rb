class InfosController < ApplicationController
  before_action :check_for_empty_info, only: [:edit]
  before_action :find_info, only: [:edit, :update]
  before_action :set_companies, except: [:create]

  def new
    if current_user.info.blank?
      @info = Info.new
    else
      redirect_to edit_info_url
    end
  end

  def create
    @info = Info.new(info_params.merge user_id: current_user.id)
    if @info.save
      flash[:notice] = "Спасибо, теперь Вы можете пройти тест."
      redirect_to take_survey_url(current_user.surveys.create!)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @info.update(info_params)
      flash[:notice] = "Ваши данные обновлены."
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
				 :work_position,
				 :company)
  end

  def find_info
    @info = Info.find(current_user.info.id)
  end

  def set_companies
    @companies = Company.all
  end
end
