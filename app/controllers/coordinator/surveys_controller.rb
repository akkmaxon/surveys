class Coordinator::SurveysController < Coordinator::ApplicationController
  def index
    @surveys = Survey.paginate(page: params[:page], per_page: 12)
  end

  def show
    @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос №#{params[:id]} не существует"
    redirect_to coordinator_surveys_url
  end
end
