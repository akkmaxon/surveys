class SurveysController < ApplicationController
  before_action :check_for_empty_info
  before_action :set_survey, only: [:show, :take, :update]
  before_action :check_for_survey_owner, only: [:show, :take]
  before_action :check_for_not_completed_survey, only: [:create]

  def index
    @surveys = current_user.completed_surveys
  end

  def show
    @criteria = Question.group_by_criterion(current_user)
    # {'first' => [1,2], 'second' => [3,4], 'third' => [5,6]}
  end

  def create
    @survey = @not_completed_survey ? @not_completed_survey : current_user.surveys.create!
    redirect_to take_survey_url(@survey)
  end

  def take
    @first_questions = Question.first_questions_for(current_user)
    @second_questions = Question.second_questions_for(current_user)
    @sum_of_questions = @first_questions.size + @second_questions.size
  end

  def update
    @survey.update(surveys_params)
    if surveys_params.key?(:completed)
      if @survey.reliable?
	flash[:notice] = "Опрос завершен."
	redirect_to @survey
      else
	@survey.destroy
	flash[:alert] = "С большой долей вероятности можно сказать, что Вы отвечали не совсем искренне, поэтому мы считаем Ваши данные недостоверными."
	redirect_to root_path
      end
    end
    if surveys_params.key?(:user_email)
      redirect_to surveys_url
    end
  end

  private

  def surveys_params
    params.require(:survey).permit(:user_agreement, :user_email, :completed)
  end

  def set_survey
    @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос №#{params[:id]} не существует"
    redirect_to surveys_url
  end

  def check_for_survey_owner
    unless current_user.surveys.include?(@survey)
      flash[:alert] = "Вы не можете видеть результаты других пользователей"
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
