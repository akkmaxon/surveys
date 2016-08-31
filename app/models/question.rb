class Question < ApplicationRecord
  has_one :left_statement, dependent: :destroy
  has_one :right_statement, dependent: :destroy

  default_scope -> { order(number: :asc) }

  validates :audience, inclusion: { in: %w[management working_staff] }
  validates :number, presence: true
  validates :number, numericality: { only_integer: true }
  validates :opinion_subject, inclusion: { in: ["Я", "Мои коллеги"] }
  validates :criterion, presence: true

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
end
