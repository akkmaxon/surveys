class SurveysController < ApplicationController
  before_action :check_for_empty_info
  before_action :find_survey, only: [:show, :take, :update]
  before_action :check_for_survey_owner, only: [:show, :take]
  before_action :check_for_not_completed_survey, only: :create

  def index
    @surveys = current_user.surveys
  end

  def show
  end

  def create
    @survey = @not_completed_survey ? @not_completed_survey : current_user.surveys.create!
    redirect_to take_survey_url(@survey)
  end

  def take
    @questions = Question.for(current_user)
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

  def check_for_not_completed_survey
    if current_user.surveys.blank?
      @not_completed_survey = false
    else
      last_survey = current_user.surveys.first
      @not_completed_survey = last_survey.completed? ? false : last_survey
    end
  end
end
