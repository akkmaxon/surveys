module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.surveys.first # descending ordering
    survey.id == newest_survey.id ? "in" : ""
  end

  def text_for(subject)
    if subject == "Я"
      "С какой из групп Вы более согласны?"
    else
      "Как Вы считаете, с каким мнением согласится большинство Ваших коллег?"
    end
  end
end
