module Admin::QuestionsHelper
  def next_number_for_question(last_question)
    last_question.blank? ? 1 : (last_question.number + 1)
  end
end
