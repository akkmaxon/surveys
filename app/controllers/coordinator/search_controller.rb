class Coordinator::SearchController < Coordinator::ApplicationController
  def search
    q = params[:search_query]
    @nothing_found = false
    @users = User.search_for_query(q)
    @surveys = Survey.search_for_query(q)
    if (@users.blank? and @surveys.blank?) or q.blank?
      @nothing_found = true
      @total_count = 0
    else
      @total_count = [@users, @surveys].inject(0) { |sum, i| sum + i.count }
    end
  end
end
