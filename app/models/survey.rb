class Survey < ApplicationRecord
  RSUM = 11

  belongs_to :user
  has_many :responses, dependent: :delete_all
  validates :user, presence: true

  default_scope -> { order(created_at: :desc) }

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
    mem_before = `ps -o rss= -p #{Process.pid}`.to_i/1024
    exporter = SurveysExporter.new EXPORT_FILE
    exporter.create_csv
    lim = 100
    (0..count).step(lim) do |n|
      csv = exporter.to_csv(all.reorder(:id).offset(n).limit(lim))
      File.open(EXPORT_FILE, 'a') { |f| f.write csv }
    end
    mem_after = `ps -o rss= -p #{Process.pid}`.to_i/1024
    puts mem_before
    puts mem_after
    [Survey,Response,User,Info].each do |obj|
      puts ObjectSpace.each_object(obj).count
    end
    File.open(EXPORT_FILE).read
  end

  def pass_date
    updated_at.strftime "%d.%m.%Y"
  end

  def answer_for(question_number)
    resp_arr = responses.pluck(:question_number, :answer)
    resp = resp_arr.find { |a| a.first == question_number }
    resp.last unless resp.nil?
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

  #TODO: delete
  def total_assessment_for(question_numbers = [])
    # formula: (a1 + a2 + ... + an)/n * 5/6
    if question_numbers.empty?
      nil
    else
      total = question_numbers.inject(0) do |sum, n|
	sum += answer_for(n).to_f
      end / question_numbers.size
      (total * report_correction).round(2)
    end
  end

  def reliable?
    resp29 = responses.find_by(question_number: 29)
    resp30 = responses.find_by(question_number: 30)
    if resp29.nil? and resp30.nil?
      true
    else
      sum = resp29.answer.to_i + resp30.answer.to_i
      sum < RSUM ? true : false
    end
  end

  def to_param
    (id + CRYPT_SURVEY).to_s(36)
  end

  private

    def report_correction
      5.0 / 6.0
    end
end
