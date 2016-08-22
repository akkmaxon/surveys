class SurveysController < ApplicationController
  before_action :check_for_empty_info, only: [:index, :show]

  def index
    @surveys = current_user.surveys
  end

  def show
    @survey = Survey.find(params[:id])
  end
end
