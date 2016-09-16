class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def about
    if admin_signed_in?
      redirect_to admin_root_url
    elsif coordinator_signed_in?
      redirect_to coordinator_root_url
    elsif user_signed_in?
      redirect_to surveys_url
    end
  end
end
