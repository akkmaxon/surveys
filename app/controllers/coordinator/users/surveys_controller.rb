class Coordinator::Users::SurveysController < Coordinator::ApplicationController
  def index
    @user = User.find_by(login: params[:user_id])
    @surveys = Survey.where(user_id: @user.id)
  end

  def show
    @survey = Survey.find(params[:id].to_i(36) - CRYPT_SURVEY)
    @user = @survey.user
    @info = @user.info
    @first_responses = @survey.responses.on_first_questions
    @second_responses = @survey.responses.on_second_questions
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос #{params[:id]} не существует"
    redirect_to coordinator_surveys_url
  end
end
