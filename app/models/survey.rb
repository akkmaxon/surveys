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
    ### fill in first worksheet
    first = workbook.create_worksheet name: "Общая информация"
    first.row(0).default_format = bold
    headings_first_worksheet.each do |cell|
      first.row(0).push cell
    end
    all.reorder(:id).each_with_index do |survey, i|
      data_first_worksheet(survey).each do |cell|
	first.row(i + 1).push cell
      end
    end
    column_widths.each_with_index do |width, i|
      first.column(i).width = width
    end
    ### fill in second worksheet
    second = workbook.create_worksheet name: "Ответы"
    # TODO
    workbook
  end

  private

  def self.headings_first_worksheet
    ["Номер опроса", "Дата прохождения опроса", "Опрос для",
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

  def self.headings_second_worksheet
  end

  def self.column_widths
    [15, 25, 25, 20, 20, 20, 30, 30, 30, 25, 30, 50]
  end

  def self.data_second_worksheet
  end
end
