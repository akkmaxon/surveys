class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:update_csv]
  before_action :devise_sanitizer_params, if: :devise_controller?

  protect_from_forgery with: :exception

  def update_csv
    Survey.delay(run_at: Time.now).export
  end

  protected

  def devise_sanitizer_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end

  def check_for_empty_info
    if current_user.info.blank?
      flash[:notice] = "Перед началом работы заполните, пожалуйста, некоторые данные о себе."
      redirect_to new_info_url
    end
  end

  def array_to_relation(model, query_result)
    query_result.class == Array ? model.where(id: query_result.map(&:id)) : query_result
  end
end
