class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :devise_sanitizer_params, if: :devise_controller?

  protect_from_forgery with: :exception

  def devise_sanitizer_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end

  def check_for_empty_info
    if current_user.info.blank?
      flash[:notice] = "Перед началом работы заполните, пожалуйста, некоторые данные о себе."
      redirect_to new_info_url
    end
  end
end
