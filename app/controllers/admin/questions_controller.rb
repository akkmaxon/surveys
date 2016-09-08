class Admin::QuestionsController < Admin::ApplicationController
  before_action :set_questions, only: [:index, :create]

  def index
    @new_question = Question.new
  end

  def create
    @new_question = Question.new(question_params)
    if @new_question.save
      flash[:notice] = "Вопрос создан."
      redirect_back(fallback_location: admin_questions_path)
    else
      render :index
    end
  end

  private

  def question_params
    params.require(:question).permit(:number, :audience, :opinion_subject, :criterion)
  end

  def set_questions
    @first_questions = Question.all_first_questions
    @second_questions = Question.all_second_questions
  end
end
