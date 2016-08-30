module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.completed_surveys.first
    survey.id == newest_survey.id ? "in" : ""
  end

  def text_for_subject(subject)
    case subject
    when "Я"
      "<p class='subject_with_arrows'>&larr;<strong>Я</strong>&rarr;</p>
      <p>Мнение какой из групп Вам ближе?</p>"
    when "Мои коллеги"
      "<p class='subject_with_arrows'>&larr;<strong>Мои коллеги</strong>&rarr;</p>
      <p>С чем согласится большинство Ваших коллег?</p>"
    end.html_safe
  end
end
