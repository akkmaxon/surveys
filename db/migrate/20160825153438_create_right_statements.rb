class CreateRightStatements < ActiveRecord::Migration[5.0]
  def change
    create_table :right_statements do |t|
      t.string :title, default: ""
      t.text :text, default: ""
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
