class Coordinator::ApplicationController < ApplicationController
  before_action :authenticate_coordinator!
  skip_before_action :authenticate_user!

  def index
  end

  def surveys_export
    render xls: Survey.export_xls, name: "Опросы #{Time.now.strftime '%d.%m.%Y'}"
  end

  private
  
  def count_first_questions
    max = Response.on_first_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_first_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end

  def count_second_questions
    max = Response.on_second_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_second_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end
end
