class AddCriterionTypeToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :criterion_type, :string, default: ""
  end
end
