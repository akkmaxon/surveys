class SurveysController < ApplicationController
  before_action :check_for_empty_info
  before_action :find_survey, only: [:show, :edit, :update]
  before_action :check_for_survey_owner, only: [:show, :edit]
  before_action :check_for_blank_survey, only: :create

  def index
    @surveys = current_user.surveys
  end

  def show
  end

  def create
    @survey = @blank_survey ? @blank_survey : current_user.surveys.create!
    redirect_to edit_survey_url(@survey)
  end

  def edit
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

  def check_for_survey_owner
    unless current_user.surveys.include?(@survey)
      flash[:alert] = 'You are not allowed to watch other people\'s surveys!'
      redirect_to surveys_url
    end
  end

  def check_for_blank_survey
    last_survey = current_user.surveys.first
    @blank_survey = last_survey.responses.blank? ? last_survey : false
  end
end
