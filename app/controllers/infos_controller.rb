class InfosController < ApplicationController
  before_action :check_for_empty_info, only: [:edit]
  def new
  end

  def edit
    @info = Info.find(current_user.info.id)
  end
end
