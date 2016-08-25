class AddQuestionReferenceToResponses < ActiveRecord::Migration[5.0]
  def change
    add_reference :responses, :question, foreign_key: true
  end
end
