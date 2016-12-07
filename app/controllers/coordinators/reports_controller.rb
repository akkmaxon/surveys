class Coordinators::ReportsController < Coordinators::ApplicationController
  def index
    if params[:survey]
      report = Report.new([Survey.find(params[:survey].to_i(36) - CRYPT_SURVEY)])
      @tables = report.create_tables!
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
