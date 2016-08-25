class Question < ApplicationRecord
  has_one :left_statement, dependent: :destroy
  has_one :right_statement, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates :audience, inclusion: { in: %w[management working_staff] }

  def self.for(user)
    if user.manager?
      where(audience: 'management')
    else
      where(audience: 'working_staff')
    end
  end
end
