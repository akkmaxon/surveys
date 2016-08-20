class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.string :question, default: ""
      t.string :answer, default: ""
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
