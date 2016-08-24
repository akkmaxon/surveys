class SurveysController < ApplicationController
  before_action :check_for_empty_info, only: [:index, :show, :new]
  before_action :find_survey, only: [:show, :update]

  def index
    @surveys = current_user.surveys
  end

  def show
    unless current_user.surveys.include?(@survey)
      flash[:alert] = 'You are not allowed to watch other people\'s surveys!'
      redirect_to surveys_url
    end
  end

  def new
  end

  def update
    @survey.update(surveys_params)
    if surveys_params.key?(:user_email)
      flash[:notice] = "Спасибо за уделенное время."
      redirect_to surveys_url
    end
  end

  private

  def surveys_params
    params.require(:survey).permit(:user_agreement, :user_email)
  end

  def find_survey
    @survey = Survey.find(params[:id])
  end
end
