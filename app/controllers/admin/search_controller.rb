class Admin::SearchController < Admin::ApplicationController
  def search
    q = params[:search_query]
    @nothing_found = false
    @users = array_to_relation(User, User.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    @coordinators = array_to_relation(Coordinator, Coordinator.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    @companies = array_to_relation(Company, Company.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    @questions = array_to_relation(Question, Question.search_for_query(q)).paginate(page: params[:page], per_page: 12)
    if (@users.blank? and @coordinators.blank? and @companies.blank? and @questions.blank?) or q.blank?
      @nothing_found = true
      @total_count = 0
    else
      @total_count = [@users, @coordinators, @companies, @questions].inject(0) { |sum, i| sum + i.count }
    end
  end
end
