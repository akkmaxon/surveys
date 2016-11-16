class Coordinators::SurveysController < Coordinators::ApplicationController
  def index
    if params[:user]
      user = User.find_by(login: params[:user])
      @filter_name = user.login
      @surveys = Survey.where(user: user).paginate(page: params[:page], per_page: 12)
    elsif params[:company]
      #TODO
      @filter_name = params[:company]
      @surveys = Survey.where("id < ?", 10)
    elsif params[:work_position]
      #TODO
      @filter_name = params[:work_position]
      @surveys = Survey.where("id < ?", 10)
    else
      @filter_name = "все"
      @surveys = Survey.paginate(page: params[:page], per_page: 12)
    end
  rescue
    flash[:alert] = "Запись не найдена"
    redirect_to coordinators_surveys_url
  end

  def show
    @survey = Survey.find(params[:id].to_i(36) - CRYPT_SURVEY)
    @user = @survey.user
    @info = @user.info
    @first_responses = @survey.responses.on_first_questions
    @second_responses = @survey.responses.on_second_questions
    @involvement_criteria = Question.group_by_criterion(@survey, "Вовлеченность")
    @satisfaction_criteria = Question.group_by_criterion(@survey, "Удовлетворенность")
    @last_criteria = Question.group_by_criterion(@survey, '')
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Опрос #{params[:id]} не существует"
    redirect_to coordinators_surveys_url
  end

  def export
    file = File.open(EXPORT_FILE, 'r')
    respond_to do |format|
      format.csv { send_data file.read, filename: "Опросы(#{file.mtime.strftime '%d.%m.%Y'}).csv" }
    end
  end
end
