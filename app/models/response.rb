class Response < ApplicationRecord
  belongs_to :survey

  validates :question_number, :answer, presence: true
  validates :question_number, numericality: { only_integer: true }
end
