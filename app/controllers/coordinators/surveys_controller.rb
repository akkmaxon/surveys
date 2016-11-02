class Coordinators::SurveysController < Coordinators::ApplicationController
  def index
    @surveys = Survey.paginate(page: params[:page], per_page: 12)
  end

  def export
    file = File.open(EXPORT_FILE, 'r')
    respond_to do |format|
      format.csv { send_data file.read, filename: "Опросы(#{file.mtime.strftime '%d.%m.%Y'}).csv" }
    end
  end
end
