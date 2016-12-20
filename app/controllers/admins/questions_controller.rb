class Admins::QuestionsController < Admins::ApplicationController
  before_action :set_question, only: [:update, :destroy]

  def index
    @question = Question.new
    @total_count = Question.count
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      if @question.sentence.blank?
	LeftStatement.create(left_statement_params)
	RightStatement.create(right_statement_params)
      end
      flash[:notice] = "Вопрос создан."
      redirect_to admins_questions_path
    else
      render :index
    end
  end

  def update
    if @question.update(question_params)
      t = if @question.sentence.blank?
	    @question.left_statement.update(left_statement_params)
	    @question.right_statement.update(right_statement_params)
	    '_first_question'
	  else
	    '_second_question'
	  end
      render t, locals: { question: @question }, layout: false
    end
  end

  def destroy
    @question.destroy
    render plain: "Success"
  end

  private

  def question_params
    p = params.require(:question).permit(:title,
					 :number,
					 :audience,
					 :opinion_subject,
					 :criterion,
					 :criterion_type,
					 :sentence)
    p[:number] = (p[:number].to_i + 200).to_s unless p[:sentence].blank?
    p
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
