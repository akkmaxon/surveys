class Question < ApplicationRecord
  has_one :left_statement, dependent: :destroy
  has_one :right_statement, dependent: :destroy

  validates :audience, inclusion: { in: %w[management working_staff] }
  validates :number, presence: true
  validates :number, numericality: { only_integer: true }
  validates :opinion_subject, inclusion: { in: ["Я", "Мои коллеги"] }
  validates :criterion, presence: true

  default_scope -> { order(number: :asc) }

  scope :all_first_questions, -> { where('sentence = ?', "") }
  scope :all_second_questions, -> { where('sentence != ?', "") }

  def self.for(user)
    if user.manager?
      where(audience: 'management')
    else
      where(audience: 'working_staff')
    end
  end

  def self.first_questions_for(user)
    self.for(user).where('sentence = ?', "")
  end

  def self.second_questions_for(user)
    self.for(user).where('sentence != ?', "")
  end

  def self.group_by_criterion(user)
    questions = self.first_questions_for(user)
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
end
