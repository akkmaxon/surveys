class SurveysController < ApplicationController
  def index
    @surveys = current_user.surveys
  end
end
