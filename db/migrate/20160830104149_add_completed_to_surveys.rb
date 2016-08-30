class AddCompletedToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :completed, :boolean, default: false
  end
end
