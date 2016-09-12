class Admin::SurveysController < Admin::ApplicationController
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос №#{params[:id]} не существует"
    redirect_to admin_surveys_url
  end
end
