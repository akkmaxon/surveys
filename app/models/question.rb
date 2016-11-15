class Question < ApplicationRecord
  has_one :left_statement, dependent: :delete
  has_one :right_statement, dependent: :delete

  validates :audience, inclusion: { in: ["Менеджмент", "Рабочая специальность"] }
  validates :number, presence: true
  validates :number, numericality: { only_integer: true }
  validates :opinion_subject, inclusion: { in: ["Я", "Мои коллеги"] }
  validates :criterion, presence: true
  validates :criterion_type, inclusion: { in: ["Вовлеченность", "Удовлетворенность", "Отношение к руководству" ] }, allow_blank: true

  default_scope -> { order(audience: :asc).order(number: :asc) }

  scope :all_first_questions, -> { where('sentence = ?', "") }
  scope :all_second_questions, -> { where('sentence != ?', "") }

  def self.for_management_count
    where('audience = ?', "Менеджмент").count 
  end

  def self.for_working_staff_count
    where('audience = ?', "Рабочая специальность").count 
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
    criteria = questions.pluck(:criterion)
    if criterion_type == "Вовлеченность"
      bosses_numbers = self.first_questions_for(survey).
	where(criterion_type: "Отношение к руководству").pluck(:number)
      bosses = { "Отношение к руководству (общее)" => bosses_numbers }
      criteria.inject(bosses) do |result, criterion|
	result.merge(criterion => questions.where('criterion = ?', criterion).pluck(:number))
      end.invert.sort.to_h.invert
    else
      criteria.inject({}) do |result, criterion|
	result.merge(criterion => questions.where('criterion = ?', criterion).pluck(:number))
      end
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

  def self.search_for_query(query)
    result = []
    %w[criterion sentence].each do |column|
      result.concat where("#{column} ilike ?", "%#{query}%").to_a
    end
    [LeftStatement, RightStatement].each do |st|
      q_ids = st.search_for_query(query).pluck(:question_id)
      result.concat find(q_ids)
    end
    result.sort.uniq
  end
end
