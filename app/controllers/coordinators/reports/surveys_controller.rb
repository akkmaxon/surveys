class Coordinators::Reports::SurveysController < Coordinators::ApplicationController
  def show
    report = Report.new([Survey.find(params[:id].to_i(36) - CRYPT_SURVEY)])
    @tables = report.create_tables!
    render 'coordinators/shared/report'
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос #{params[:id]} не существует"
    redirect_to coordinators_surveys_url
  end
end
