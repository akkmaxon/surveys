class Question < ApplicationRecord
  has_one :left_statement, dependent: :destroy
  has_one :right_statement, dependent: :destroy

  validates :audience, inclusion: { in: %w[management working_staff] }
  validates :number, presence: true
  validates :number, numericality: { only_integer: true }

  def self.for(user)
    if user.manager?
      where(audience: 'management')
    else
      where(audience: 'working_staff')
    end
  end
end
