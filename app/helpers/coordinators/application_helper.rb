module Coordinators::ApplicationHelper
  # sign for every filter
  def owned_by
    params.key?(:filter) ? "(" + params[:filter] + ")" : nil
  end
end
