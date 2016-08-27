class AddSentenceToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :sentence, :text, default: ""
  end
end
