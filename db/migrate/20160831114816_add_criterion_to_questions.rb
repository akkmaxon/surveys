class AddCriterionToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :criterion, :string
  end
end
