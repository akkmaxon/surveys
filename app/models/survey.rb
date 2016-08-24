class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def pass_date
    created_at.strftime "%d %B %Y"
  end
end
