class Coordinators::Reports::UsersController < Coordinators::ApplicationController
  def show
    render plain: 'Hi from coordinators/reports/users'
  end
end
