class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :set_users, only: [:index, :create]

  def index
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_decrypted_password(params[:user][:password])
      flash.now[:notice] = "Новый респондент успешно создан."
      render :show
    else
      render :index
    end
  end

  def update
    if @user.update(user_params)
      @user.update_decrypted_password(params[:user][:password])
      flash[:notice] = "Респондент успешно изменен."
      redirect_to admin_user_url(@user)
    else
      @user.reload
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.order(updated_at: :desc).paginate(page: params[:page], per_page: 10)
  end
end
