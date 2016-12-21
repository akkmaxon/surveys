class CreateWorkPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :work_positions do |t|
      t.string :title

      t.timestamps
    end
  end
end
