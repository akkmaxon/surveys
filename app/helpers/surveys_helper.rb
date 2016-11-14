module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.completed_surveys.first
    survey.id == newest_survey.id ? "in" : ""
  end

  def answer_assessment(survey, question_number, sub)
    question = Question.find_by(number: question_number)
    question.opinion_subject == sub ? survey.answer_for(question_number) : nil
  end
end
