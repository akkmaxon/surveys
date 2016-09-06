class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :update]

  def index
    @users = User.order(updated_at: :desc)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Новый респондент успешно создан."
      redirect_to admin_users_url
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      if user_params.key?(:login)
	flash[:notice] = "Логин респондента успешно изменен."
      elsif user_params.key?(:password)
	flash[:notice] = "Пароль респондента успешно изменен."
      end
      redirect_to admin_user_url(@user)
    else
      @user.reload
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
