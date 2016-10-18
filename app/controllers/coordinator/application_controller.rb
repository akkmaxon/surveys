class Coordinator::ApplicationController < ApplicationController
  before_action :authenticate_coordinator!
  skip_before_action :authenticate_user!

  def index
    redirect_to coordinator_surveys_url
  end
end
