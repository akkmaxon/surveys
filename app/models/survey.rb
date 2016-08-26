class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def pass_date
    created_at.strftime "%d %B %Y"
  end

  def answer_for(question_number)
    resp = responses.find_by(question_number: question_number)
    resp.answer unless resp.nil?
  end

  def sum_of(question_numbers = [])
    sum = 0
    question_numbers.each do |n|
      sum += answer_for(n).to_i
    end
    sum
  end
end
