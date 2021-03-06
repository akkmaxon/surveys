class Admins::UsersController < Admins::ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :set_users

  def index
    @user = User.new
  end

  def show
    render pdf: @user.login
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_credentials] = user_params
      flash[:notice] = "Респондент создан."
      redirect_to admins_users_url
    else
      render :index
    end
  end

  def update
    if @user.update(user_params)
      session[:user_credentials] = user_params
      flash[:notice] = "Респондент изменен."
      redirect_to admins_users_url
    else
      @user.reload
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end

  def set_user
    @user = User.find_by(login: params[:id])
  end

  def set_users
    @users = User.order(updated_at: :desc).paginate(page: params[:page], per_page: 12)
  end
end
