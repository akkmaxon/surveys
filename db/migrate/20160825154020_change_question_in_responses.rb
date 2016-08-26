class ChangeQuestionInResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :responses, :question, :string
    add_column :responses, :question_number, :integer
  end
end
