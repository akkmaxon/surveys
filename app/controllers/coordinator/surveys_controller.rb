class Coordinator::SurveysController < Coordinator::ApplicationController
  def index
    @surveys = Survey.paginate(page: params[:page], per_page: 12)
  end
end
