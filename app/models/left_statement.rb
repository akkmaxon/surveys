class LeftStatement < ApplicationRecord
  belongs_to :question

  validates :text, presence: true

  def self.search_for_query(query)
    result = []
    %w[title text].each do |column|
      result.concat where("#{column} ilike ?", "%#{query}%")
    end
    result.uniq
  end
end
