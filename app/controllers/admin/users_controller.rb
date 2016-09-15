class Admin::UsersController < Admin::ApplicationController
  before_action :set_users

  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_decrypted_password(params[:user][:password])
      flash[:notice] = "Респондент создан."
      redirect_back(fallback_location: admin_companies_url)
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user.update_decrypted_password(params[:user][:password])
      flash[:notice] = "Респондент изменен."
      redirect_back(fallback_location: admin_companies_url)
    else
      @user.reload
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end

  def set_users
    @users = User.order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
  end
end
