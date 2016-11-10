module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.completed_surveys.first
    survey.id == newest_survey.id ? "in" : ""
  end

  def answer_assessment_me(survey, question_number)
    question = Question.find(question_number)
    question.opinion_subject == "Я" ? survey.answer_for(question_number) : nil
  end

  def answer_assessment_my_colleagues(survey, question_number)
    question = Question.find(question_number)
    question.opinion_subject == "Мои коллеги" ? survey.answer_for(question_number) : nil
  end
end
