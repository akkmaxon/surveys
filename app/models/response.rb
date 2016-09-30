class Response < ApplicationRecord
  belongs_to :survey

  validates :question_number, presence: true
  validates :question_number, numericality: { only_integer: true }

  default_scope -> { order(question_number: :asc) }
  scope :on_first_questions, -> { where('question_number < ?', 200) }
  scope :on_second_questions, -> { where('question_number > ?', 200) }
end
