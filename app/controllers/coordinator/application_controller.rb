class Coordinator::ApplicationController < ApplicationController
  before_action :authenticate_coordinator!
  skip_before_action :authenticate_user!

  def index
  end

  def surveys_export
    @surveys = Survey.all.reorder(:id)
    @max_first_questions_count = Survey.all.max do |a,b|
      a.responses.on_first_questions.count <=> b.responses.on_first_questions.count
    end.responses.on_first_questions.count
    @max_second_questions_count = Survey.all.max do |a,b|
      a.responses.on_second_questions.count <=> b.responses.on_second_questions.count
    end.responses.on_second_questions.count
    render xls: "Опросы(#{Time.now.strftime '%d.%m.%Y'})"
  end
end
