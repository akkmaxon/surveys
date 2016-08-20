class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :gender
      t.string :experience
      t.string :age
      t.string :workplace_number
      t.string :work_position
      t.references :user, foreign_key: true, index: true, unique: true

      t.timestamps
    end
  end
end
