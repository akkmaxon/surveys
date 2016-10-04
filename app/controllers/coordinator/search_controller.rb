class Coordinator::SearchController < Coordinator::ApplicationController
  def search
    q = params[:search_query]
    @nothing_found = false
    @users = array_to_relation(User, User.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    @surveys = array_to_relation(Survey, Survey.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    if (@users.blank? and @surveys.blank?) or q.blank?
      @nothing_found = true
      @total_count = 0
    else
      @total_count = [@users, @surveys].inject(0) { |sum, i| sum + i.count }
    end
  end
end
