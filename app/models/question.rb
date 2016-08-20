class Question < ApplicationRecord
  validates :text, :audience, presence: true
  validates :audience, inclusion: { in: %w[management working_staff] }
end
