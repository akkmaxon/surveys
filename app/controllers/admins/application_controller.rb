class Admins::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!

  def index
    redirect_to admins_users_url
  end

  def clean_person_credentials
    session.delete(params[:person_credentials])
    redirect_back(fallback_location: admins_root_path)
  end
end
