class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :devise_sanitizer_params, if: :devise_controller?

  protect_from_forgery with: :exception

  def devise_sanitizer_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

  def check_for_empty_info
    if current_user.info.blank?
      flash[:notice] = 'Fill a form about yourself'
      redirect_to new_info_url
    end
  end
end
