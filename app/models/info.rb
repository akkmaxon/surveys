class Info < ApplicationRecord
  belongs_to :user

  validates :gender,
    :experience,
    :age,
    :workplace_number,
    :work_position,
    :company,
    presence: true

  
  def self.search_for_query(query)
    result = []
    %w[work_position gender company].each do |column|
      result.concat where("#{column} ilike ?", "%#{query}%")
    end
    result.uniq
  end
end
