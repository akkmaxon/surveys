class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :question

  validates :answer, presence: true
end
