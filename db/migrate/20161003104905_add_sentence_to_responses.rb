class AddSentenceToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :sentence, :string, default: ""
  end
end
