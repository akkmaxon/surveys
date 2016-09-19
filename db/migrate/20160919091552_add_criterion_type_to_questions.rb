class AddCriterionTypeToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :criterion_type, :string, default: ""
  end
end
