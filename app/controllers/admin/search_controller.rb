class Admin::SearchController < Admin::ApplicationController
  def search
    q = params[:search_query]
    @nothing_found = false
    @users = User.search_for_query(q)
    @coordinators = Coordinator.search_for_query(q)
    @companies = Company.search_for_query(q)
    @questions = Question.search_for_query(q)
    if (@users.blank? and @coordinators.blank? and @companies.blank? and @questions.blank?) or q.blank?
      @nothing_found = true
      @total_count = 0
    else
      @total_count = [@users, @coordinators, @companies, @questions].inject(0) { |sum, i| sum + i.count }
    end
  end
end
