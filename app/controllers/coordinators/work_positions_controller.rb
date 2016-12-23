class Coordinators::WorkPositionsController < Coordinators::ApplicationController
  def index
    @work_positions = WorkPosition.all
  end
end
