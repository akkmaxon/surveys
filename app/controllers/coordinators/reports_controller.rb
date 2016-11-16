class Coordinators::ReportsController < Coordinators::ApplicationController
  def index
    if params[:survey]
      @survey = Survey.find(params[:survey].to_i(36) - CRYPT_SURVEY)
      @user = @survey.user
      @info = @user.info
      @first_responses = @survey.responses.on_first_questions
      @second_responses = @survey.responses.on_second_questions
      @involvement_criteria = Question.group_by_criterion(@survey, "Вовлеченность")
      @satisfaction_criteria = Question.group_by_criterion(@survey, "Удовлетворенность")
      @last_criteria = Question.group_by_criterion(@survey, '')
    elsif params[:user]
      # отчет по всем опросам пользователя
    elsif params[:company]
      # отчет по всем опросам для компании
    elsif params[:work_position]
      # отчет по всем опросам для должности
    else
      flash[:alert] = "Что-то пошло не так"
      redirect_to coordinators_surveys_url
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос #{params[:id]} не существует"
    redirect_to coordinators_surveys_url
  end
end
