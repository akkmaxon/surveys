class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  def pass_date
    updated_at.strftime "%d.%m.%Y"
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

  def reliable?
    resp28 = responses.find_by(question_number: 28)
    resp29 = responses.find_by(question_number: 29)
    if resp28.nil? and resp29.nil?
      true
    else
      resp28.answer != "5" || resp29.answer != "5"
    end
  end

  def self.search_for_query(query)
    result = []
    possible_id = query.to_i
    unless possible_id == 0
      survey = find(possible_id)
      result.push(survey) unless survey.nil?
    end
    %w[user_email user_agreement audience].each do |column|
      result.concat where("#{column} ilike ?", "%#{query}%").to_a
    end
    u_ids = User.search_for_query(query).pluck(:id)
    u_ids.each do |user_id|
      survey = find_by(user_id: user_id)
      result.push(survey) unless survey.nil?
    end
    result.uniq
  end

  def self.export
    SurveysExporter.new(all.reorder(:id)).to_xls
  end
end
