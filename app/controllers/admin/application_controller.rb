class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!

  def index
  end

  def clean_person_credentials
    session.delete(params[:person_credentials])
    redirect_back(fallback_location: admin_root_path)
  end
end
