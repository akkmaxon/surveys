class Survey < ApplicationRecord
  belongs_to :user
  has_many :responses, dependent: :delete_all

  default_scope -> { order(created_at: :desc) }

  def pass_date
    updated_at.strftime "%d.%m.%Y"
  end

  def answer_for(question_number)
    resp_arr = responses.pluck(:question_number, :answer)
    resp = resp_arr.find { |a| a[0] == question_number }
    resp[1] unless resp.nil?
  end

  def criterion_for(question_number)
    resp = responses.find_by(question_number: question_number)
    resp.criterion unless resp.nil?
  end

  def criterion_type_for(question_number)
    resp = responses.find_by(question_number: question_number)
    resp.criterion_type unless resp.nil?
  end

  def sentence_for(question_number)
    resp = responses.find_by(question_number: question_number)
    resp.sentence unless resp.nil?
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
      begin
	survey = find(possible_id)
      rescue ActiveRecord::RecordNotFound
	survey = nil
      end
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
    exporter = SurveysExporter.new(EXPORT_FILE)
    exporter.create_csv
    lim = 100
    (0..all.count).step(lim) do |n|
      csv = exporter.to_csv(all.reorder(:id).offset(n).limit(lim))
      File.open(EXPORT_FILE, 'a') { |f| f.write csv }
    end
    File.open(EXPORT_FILE).read
  end

  def to_param
    (id + CRYPT_SURVEY).to_s(36)
  end
end
