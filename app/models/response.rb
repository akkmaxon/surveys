class Response < ApplicationRecord
  belongs_to :survey

  validates :question, presence: true
  validates :answer, presence: true
end
