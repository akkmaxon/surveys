class Report
  attr_reader :responses, :tables

  REPORT_CORRECTION = 5.0 / 6.0

  def initialize(surveys = [])
    s = []
    @responses = choose_responses((s << surveys).flatten)
    @tables = []
  end

  # create tables for every non-empty criterion type
  def create_tables!
    return [] if responses.empty?
    criterion_types = responses.pluck(:criterion_type).uniq.reject(&:empty?)
    criterion_types.each do |criterion_type|
      table = {}
      table[:criterion_type_summary] = set_criterion_type_summary(criterion_type)
      table[:rows] = set_rows_for_table(criterion_type)
      # rows: [row1, row2, row3, row4]:
      # { counter: 1,
      #   criterion: "Blablabla",
      #   question_numbers: "1, 2",
      #   answer_me: "4",
      #   answer_colleagues: "1",
      #   result: "4.12",
      # }
      table[:summary] = calculate_summary(table[:rows])
      # { rows: [row1, row2, row3, row4],
      #   criterion_type_summary: "Summary",
      #   summary: "4.21"
      # }
      @tables << table
    end
    # [table1, table2, table3]
    tables
  end

  def set_criterion_type_summary(criterion_type)
    case criterion_type
    when "Вовлеченность" then "Общий уровень вовлеченности"
    when "Удовлетворенность" then "Общий уровень удовлетворенности"
    when "Отношение к руководству" then "#{criterion_type} (общее)"
    else criterion_type
    end
  end
  
  def set_rows_for_table(criterion_type)
    rows = []
    criteria = responses.where(criterion_type: criterion_type).pluck(:criterion).uniq
    criteria.each do |criterion|
      row = {}
      resp = responses.on_first_questions.where(criterion_type: criterion_type, criterion: criterion)
      row[:counter] = rows.size + 1
      row[:criterion] = criterion
      row[:question_numbers] = resp.pluck(:question_number).uniq.join(", ")
      row[:answer_me] = calculate_result_for("Я", resp)
      row[:answer_colleagues] = calculate_result_for("Мои коллеги", resp)
      row[:result] = calculate_result_for(false, resp)
      rows << row
    end
    rows
  end

  def calculate_result_for(opinion_subject, responses)
    if opinion_subject
      resp = responses.where(opinion_subject: opinion_subject)
      answers = resp.pluck(:answer).compact
      case answers.size
      when 0
	'-'
      when 1
	answers.first
      else
	(answers.inject(0.0) { |sum, answer| sum + answer.to_f } / answers.size).round(2)
      end
    else
      answers = responses.pluck(:answer).compact
      average = answers.inject(0.0) { |sum, answer| sum + answer.to_f } / answers.size
      average == 0.0 ? '-' : (average * REPORT_CORRECTION).round(2).to_s
    end
  end

  def calculate_summary(rows)
    size = rows.reject {|row| row[:result] == '-' }.size
    return "-" if size == 0
    average = rows.inject(0.0) { |sum,row| sum + row[:result].to_f } / size
    average == 0.0 ? '-' : (average * REPORT_CORRECTION).round(2).to_s
  end

  private

  def choose_responses(surveys)
    return [] if surveys.size == 0
    ids = surveys.size == 1 ? surveys.first.id : surveys.pluck(:id)
    Response.where(survey_id: ids)
  end
end
