class Coordinators::SurveysController < Coordinators::ApplicationController
  def index
    if params[:user]
      user = User.find_by(login: params[:user])
      @filter_name = "(#{user.login})"
      @surveys = Survey.where(user: user).paginate(page: params[:page], per_page: 12)
    elsif params[:company]
    elsif params[:work_position]
    else
      @filter_name = ""
      @surveys = Survey.paginate(page: params[:page], per_page: 12)
    end
  rescue
    flash[:alert] = "Запись не найдена"
    redirect_to coordinators_surveys_url
  end

  def export
    file = File.open(EXPORT_FILE, 'r')
    respond_to do |format|
      format.csv { send_data file.read, filename: "Опросы(#{file.mtime.strftime '%d.%m.%Y'}).csv" }
    end
  end
end
