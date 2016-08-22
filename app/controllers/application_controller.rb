class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :devise_sanitizer_params, if: :devise_controller?

  protect_from_forgery with: :exception

  def devise_sanitizer_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

  def check_for_empty_info
    flash[:notice] = 'You should fill info about yourself before'
    redirect_to new_info_url if current_user.info.blank?
  end
end
