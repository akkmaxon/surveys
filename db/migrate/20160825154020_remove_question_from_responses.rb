class RemoveQuestionFromResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :responses, :question, :string
  end
end
