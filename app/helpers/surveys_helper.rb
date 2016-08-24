module SurveysHelper
  def expand_state_for(survey)
    newest_survey = current_user.surveys.first # descending ordering
    survey.id == newest_survey.id ? "in" : ""
  end
end
