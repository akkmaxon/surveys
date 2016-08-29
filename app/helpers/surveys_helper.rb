module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.surveys.first
    survey.id == newest_survey.id ? "in" : ""
  end

  def text_for_subject(subject)
    case subject
    when "Я"
      "<p><strong>Я</strong></p>
      <p>Мнение какой из групп Вам ближе?</p>"
    when "Мои коллеги"
      "<p><strong>Мои коллеги</strong></p>
      <p>С чем согласится большинство Ваших коллег?</p>"
    end.html_safe
  end
end
