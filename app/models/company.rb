class Company < ApplicationRecord
  validates :name, presence: true

  default_scope -> { order(name: :asc) }

  def self.search_for_query(query)
    []
  end
end
