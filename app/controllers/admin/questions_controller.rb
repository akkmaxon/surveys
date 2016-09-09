class Admin::QuestionsController < Admin::ApplicationController
  before_action :set_questions, only: [:index, :create]
  before_action :set_question, only: [:destroy]
  after_action :create_left_and_right_statements, only: :create

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

  def destroy
    @question.destroy
    flash[:notice] = "Вопрос удален."
    redirect_back(fallback_location: admin_questions_path)
  end

  private

  def question_params
    params.require(:question).permit(:number, :audience, :opinion_subject, :criterion, :sentence)
  end

  def set_questions
    @first_questions = Question.all_first_questions
    @second_questions = Question.all_second_questions
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def create_left_and_right_statements
    LeftStatement.create do |left|
      left.question_id = @new_question.id
      left.title = params[:left_title] || ""
      left.text = params[:left_text] || ""
    end
    RightStatement.create do |right|
      right.question_id = @new_question.id
      right.title = params[:right_title] || ""
      right.text = params[:right_text] || ""
    end
  end
end
