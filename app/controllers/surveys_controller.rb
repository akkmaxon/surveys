class SurveysController < ApplicationController
  before_action :check_for_empty_info, only: [:index, :show, :new]

  def index
    @surveys = current_user.surveys
  end

  def show
    @survey = Survey.find(params[:id])
    unless current_user.surveys.include?(@survey)
      flash[:alert] = 'You are not allowed to watch other people\'s surveys!'
      redirect_to surveys_url
    end
  end

  def new
  end
end
