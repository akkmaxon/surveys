class Coordinator::UsersController < Coordinator::ApplicationController
  def index
    @users = User.order(updated_at: :desc).paginate(page: params[:page], per_page: 12)
  end
end
