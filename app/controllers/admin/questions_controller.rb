class Admin::QuestionsController < Admin::ApplicationController
  before_action :set_questions, only: [:index, :create]
  before_action :set_question, only: [:update, :destroy]

  def index
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      if @question.sentence.blank?
	LeftStatement.create(left_statement_params)
	RightStatement.create(right_statement_params)
      end
      flash[:notice] = "Вопрос создан."
      redirect_back(fallback_location: admin_questions_path)
    else
      render :index
    end
  end

  def update
    if @question.update(question_params)
      if @question.sentence.blank?
	@question.left_statement.update(left_statement_params)
	@question.right_statement.update(right_statement_params)
      end
      flash[:notice] = "Вопрос обновлен."
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
    params.require(:question).permit(:number,
				     :audience,
				     :opinion_subject,
				     :criterion,
				     :criterion_type,
				     :sentence)
  end

  def set_questions
    @first_questions = Question.all_first_questions
    @second_questions = Question.all_second_questions
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def left_statement_params
    { question_id: @question.id,
      title: params[:left_title],
      text: params[:left_text]
    }
  end

  def right_statement_params
    { question_id: @question.id,
      title: params[:right_title],
      text: params[:right_text]
    }
  end
end
