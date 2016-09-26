class Question < ApplicationRecord
  has_one :left_statement, dependent: :delete
  has_one :right_statement, dependent: :delete

  validates :audience, inclusion: { in: %w[management working_staff] }
  validates :number, presence: true
  validates :number, numericality: { only_integer: true }
  validates :opinion_subject, inclusion: { in: ["Я", "Мои коллеги"] }
  validates :criterion, presence: true
  validates :criterion_type, inclusion: { in: %w[involvement satisfaction] }, allow_blank: true

  default_scope -> { order(audience: :asc).order(number: :asc) }

  scope :all_first_questions, -> { where('sentence = ?', "") }
  scope :all_second_questions, -> { where('sentence != ?', "") }

  def self.for_management_count
    where('audience = ?', 'management').count 
  end

  def self.for_working_staff_count
    where('audience = ?', 'working_staff').count 
  end

  def self.for(audience)
    where(audience: audience)
  end

  def self.first_questions_for(survey)
    self.for(survey.audience).where('sentence = ?', "")
  end

  def self.second_questions_for(survey)
    self.for(survey.audience).where('sentence != ?', "")
  end

  def self.group_by_criterion(survey, criterion_type)
    questions = self.first_questions_for(survey).where(criterion_type: criterion_type)
    criteria_list = questions.pluck(:criterion)
    criteria_list.inject({}) do |result, criterion|
      result.merge(criterion => questions.where('criterion = ?', criterion).pluck(:number))
    end
  end

  def left_text
    left_statement.text if left_statement
  end

  def right_text
    right_statement.text if right_statement
  end

  def left_title
    left_statement.title if left_statement
  end

  def right_title
    right_statement.title if right_statement
  end

  def audience_in_russian
    if audience == 'management'
      "Менеджмент"
    elsif audience == 'working_staff'
      "Рабочая специальность"
    end
  end

  def self.search_for_query(query)
    by_crit = where("criterion ilike ?", "%#{query}%")
    return by_crit unless by_crit.blank?
    by_sent = where("sentence ilike ?", "%#{query}%")
    return by_sent unless by_sent.blank?
    []
=begin
    by_l_tit = LeftStatement.where("title ilike ?", "%#{query}%").pluck(:question_id)
    # do something with it
    return by_l_tit unless by_l_tit.blank?
    by_r_tit = RightStatement.where("title ilike ?", "%#{query}%").inject([]) do |q, st|
      q << st
    end
    return by_r_tit unless by_r_tit.blank?
    by_l_tex = LeftStatement.where("text ilike ?", "%#{query}%").inject([]) do |q, st|
      q << st
    end
    return by_l_tex unless by_l_tex.blank?
    by_r_tex = RightStatement.where("text ilike ?", "%#{query}%").inject([]) do |q, st|
      q << st
    end
    return by_r_tex unless by_r_tex.blank?
=end
  end
end
