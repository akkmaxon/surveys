class RemoveTextFromQuestions < ActiveRecord::Migration[5.0]
  def change
    remove_column :questions, :text, :string
  end
end
