class Admin::SurveysController < Admin::ApplicationController
  def index
    @surveys = Survey.all
  end

  def show
  end
end
