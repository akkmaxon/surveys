class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :devise_sanitizer_params, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def devise_sanitizer_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:login])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end
end
