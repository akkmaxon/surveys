module Admin::QuestionsHelper
  def set_number_for_question(question, type, last_question)
    if question.number.blank?
      if last_question.blank?
	type == "first" ? 1 : 201
      else
	last_question.number + 1
      end
    else
      question.number
    end
  end
end
