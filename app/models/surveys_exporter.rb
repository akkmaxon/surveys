class SurveysExporter
  def initialize(surveys)
    @surveys = surveys
    @fqc = max_first_questions_count
    @sqc = max_second_questions_count
  end

  def to_xls
    workbook = Spreadsheet::Workbook.new
    bold = Spreadsheet::Format.new weight: :bold
    ### setting up first worksheet ###
    first = workbook.create_worksheet name: "Общая информация"
    first.row(0).default_format = bold
    headings_first_worksheet.each do |cell|
      first.row(0).push cell
    end
    first_sheet_column_widths.each_with_index do |width, i|
      first.column(i).width = width
    end
    ### setting up second worksheet ###
    second = workbook.create_worksheet name: "Ответы"
    [0,1].each { |i| second.row(i).default_format = bold }
    second.merge_cells(0, 0, 1, 0)
    second.merge_cells(0, 1, 0, @fqc)
    second.merge_cells(0, @fqc + 1, 0, @fqc + @sqc)
    second.rows[0][0] = "Опрос №"
    second.rows[0][1] = "Задание 1"
    second.rows[0][@fqc + 1] = "Задание 2"
    @fqc.times do |n|
      second.rows[1][n + 1] = n + 1
    end
    @sqc.times do |n|
      q = Question.find_by(number: "20#{n+1}".to_i)
      second.rows[1][@fqc + n + 1] = q.nil? ? "ВОПРОС УДАЛЕН" : q.sentence
    end
    second_sheet_column_widths.each_with_index do |width, i|
      second.column(i).width = width
    end
    ### populating data ###
    @surveys.each_with_index do |survey, i|
      data_first_worksheet(survey).each do |cell|
	first.row(i + 1).push cell
      end
      data_second_worksheet(survey).each do |cell|
	second.row(i + 2).push cell
      end
    end
    workbook
  end

  private

  def first_sheet_column_widths
    [10, 20, 25, 20, 20, 20, 30, 30, 30, 25, 30, 50]
  end

  def second_sheet_column_widths
    widths = Array.new(@fqc, 5)
    widths.unshift(10)
    @sqc.times { widths.push 70 }
    widths
  end

  def headings_first_worksheet
    ["Опрос №", "Дата прохождения", "Опрос для",
     "Логин", "Пол", "Возраст",
     "Компания", "Время работы в компании", "Должность",
     "Место работы по счету", "Email", "Отношение к опросу"]
  end

  def data_first_worksheet(survey)
    user = survey.user
    info = user.info
    [survey.id, survey.pass_date, survey.audience,
      user.login, info.gender, info.age,
      info.company, info.experience, info.work_position,
      info.workplace_number, survey.user_email, survey.user_agreement]
  end

  def data_second_worksheet(survey)
    data = []
    data[0] = survey.id
    @fqc.times { |n| data.push(survey.answer_for(n+1)) }
    @sqc.times { |n| data.push(survey.answer_for("20#{n+1}".to_i)) }
    data
  end

  def max_first_questions_count
    max = Response.on_first_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_first_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end

  def max_second_questions_count
    max = Response.on_second_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_second_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end
end
