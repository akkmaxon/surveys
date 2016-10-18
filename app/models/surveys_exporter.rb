class SurveysExporter
  def initialize(filename)
    @surveys = []
    @filename = filename
    @fqc = max_first_questions_count
    @sqc = max_second_questions_count
  end

  def create_csv
    csv = CSV.generate(col_sep: "\t") do |csv|
      csv << headings
    end
    File.open(@filename,'w') { |f| f.write csv }
  end

  def to_csv(surveys)
    @surveys = surveys
    CSV.generate(col_sep: "\t") do |csv|
      @surveys.each do |survey|
	csv << data_of(survey)
      end
    end
  end

  private

  def headings
    h = ["ID", "Дата прохождения", "Опрос для",
     "Логин", "Пол", "Возраст",
     "Компания", "Время работы в компании", "Должность",
     "Место работы по счету", "Email", "Отношение к опросу"]
    @fqc.times { |n| h.push(n + 1) }
    @sqc.times do |n|
      q = Question.find_by(number: "20#{n+1}".to_i)
      h.push( q.nil? ? "ВОПРОС УДАЛЕН" : q.sentence )
    end
    h
  end

  def data_of(survey)
    user = survey.user
    info = user.info
    d = [survey.id, survey.pass_date, survey.audience,
      user.login, info.gender, info.age,
      info.company, info.experience, info.work_position,
      info.workplace_number, survey.user_email, survey.user_agreement]
    @fqc.times { |n| d.push(survey.answer_for(n+1)) }
    @sqc.times { |n| d.push(survey.answer_for("20#{n+1}".to_i)) }
    d
  end

  def max_first_questions_count
    max = Response.on_first_questions.pluck(:question_number).max
    min = Response.on_first_questions.pluck(:question_number).min
    max - min + 1
  end

  def max_second_questions_count
    max = Response.on_second_questions.pluck(:question_number).max
    min = Response.on_second_questions.pluck(:question_number).min
    max - min + 1
  end
end
