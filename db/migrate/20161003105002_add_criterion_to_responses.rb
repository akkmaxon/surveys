class AddCriterionToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :criterion, :string, default: ""
  end
end
