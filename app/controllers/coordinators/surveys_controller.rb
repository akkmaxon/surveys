class Coordinators::SurveysController < Coordinators::ApplicationController
  def index
    @surveys = find_surveys
  end

  def export
    file = File.open(EXPORT_FILE, 'r')
    respond_to do |format|
      format.csv { send_data file.read, filename: "Опросы(#{file.mtime.strftime '%d.%m.%Y'}).csv" }
    end
  end

  private

  def find_surveys
    if params.key?(:filter)
      user = User.find_by(login: params[:filter])
      Survey.where(user_id: user.id)
    else
      Survey.all
    end.paginate(page: params[:page], per_page: 12)
  end
end
