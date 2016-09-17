class Coordinator::Users::SurveysController < Coordinator::ApplicationController
  def index
    @user = User.find(params[:user_id])
    @surveys = Survey.where(user_id: @user.id)
  end

  def show
    @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос №#{params[:id]} не существует"
    redirect_to coordinator_surveys_url
  end
end
