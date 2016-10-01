class Coordinator::ApplicationController < ApplicationController
  before_action :authenticate_coordinator!
  skip_before_action :authenticate_user!

  def index
  end

  def surveys_export
    render xls: Survey.export, name: "Опросы #{Time.now.strftime '%d.%m.%Y'}"
  end
end
