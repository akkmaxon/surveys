class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :text, default: ""
      t.string :audience, default: ""

      t.timestamps
    end
  end
end
