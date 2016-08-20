class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :gender, default: ""
      t.string :experience, default: ""
      t.string :age, default: ""
      t.string :workplace_number, default: ""
      t.string :work_position, default: ""
      t.references :user, foreign_key: true, index: true, unique: true

      t.timestamps
    end
  end
end
