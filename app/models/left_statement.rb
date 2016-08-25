class LeftStatement < ApplicationRecord
  belongs_to :question

  validates :title, :text, presence: true
end
