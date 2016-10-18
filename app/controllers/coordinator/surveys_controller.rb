class Coordinator::SurveysController < Coordinator::ApplicationController
  def index
    @surveys = Survey.paginate(page: params[:page], per_page: 12)
  end

  def export
    respond_to do |format|
      format.csv { send_data Survey.export, filename: "Опросы(#{Time.now.strftime '%d.%m.%Y'}).csv" }
    end
  end
end
