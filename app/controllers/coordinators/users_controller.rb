class Coordinators::UsersController < Coordinators::ApplicationController
  def index
    @users = find_users
  end

  private

  def find_users
    if params.key?(:filter)
      infos = Info.where(company: params[:filter])
      User.where(id: infos.pluck(:user_id))
    else
      User.all
    end.order(updated_at: :desc).paginate(page: params[:page], per_page: 12)
  end
end
