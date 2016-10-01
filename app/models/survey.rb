class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  def pass_date
    updated_at.strftime "%d.%m.%Y"
  end

  def answer_for(question_number)
    resp = responses.find_by(question_number: question_number)
    resp.answer unless resp.nil?
  end

  def sum_of(question_numbers = [])
    sum = 0
    question_numbers.each do |n|
      sum += answer_for(n).to_i
    end
    sum
  end

  def reliable?
    resp28 = responses.find_by(question_number: 28)
    resp29 = responses.find_by(question_number: 29)
    if resp28.nil? and resp29.nil?
      true
    else
      resp28.answer != "5" || resp29.answer != "5"
    end
  end

  def self.search_for_query(query)
    where("user_email ilike ?", "%#{query}%")
  end

  def self.export_xls
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
    second.merge_cells(0, 1, 0, max_first_questions_count)
    second.merge_cells(0, max_first_questions_count + 1, 0, max_first_questions_count + max_second_questions_count)
    second.rows[0][0] = "Опрос №"
    second.rows[0][1] = "Задание 1"
    second.rows[0][max_first_questions_count + 1] = "Задание 2"
    max_first_questions_count.times do |n|
      second.rows[1][n+1] = n + 1
    end
    max_second_questions_count.times do |n|
      q = Question.find_by(number: "20#{n+1}".to_i)
      second.rows[1][max_first_questions_count+n+1] = q.nil? ? "ВОПРОС УДАЛЕН" : q.sentence
    end
    second_sheet_column_widths.each_with_index do |width, i|
      second.column(i).width = width
    end
    ### populating data ###
    all.reorder(:id).each_with_index do |survey, i|
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

  def self.first_sheet_column_widths
    [10, 20, 25, 20, 20, 20, 30, 30, 30, 25, 30, 50]
  end

  def self.second_sheet_column_widths
    widths = Array.new(max_first_questions_count, 5)
    widths.unshift(10)
    max_second_questions_count.times { widths.push 70 }
    widths
  end

  def self.headings_first_worksheet
    ["Опрос №", "Дата прохождения", "Опрос для",
     "Логин", "Пол", "Возраст",
     "Компания", "Время работы в компании", "Должность",
     "Место работы по счету", "Email", "Отношение к опросу"]
  end

  def self.data_first_worksheet(survey)
    user = survey.user
    info = user.info
    [survey.id, survey.pass_date, survey.audience,
      user.login, info.gender, info.age,
      info.company, info.experience, info.work_position,
      info.workplace_number, survey.user_email, survey.user_agreement]
  end

  def self.data_second_worksheet(survey)
    data = []
    data[0] = survey.id
    max_first_questions_count.times { |n| data.push(survey.answer_for(n+1)) }
    max_second_questions_count.times { |n| data.push(survey.answer_for("20#{n+1}".to_i)) }
    data
  end

  def self.max_first_questions_count
    max = Response.on_first_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_first_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end

  def self.max_second_questions_count
    max = Response.on_second_questions.max do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    min = Response.on_second_questions.min do |a,b|
      a.question_number <=> b.question_number
    end.question_number
    max - min + 1
  end
end
