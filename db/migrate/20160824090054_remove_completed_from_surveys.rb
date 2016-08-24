class RemoveCompletedFromSurveys < ActiveRecord::Migration[5.0]
  def change
    remove_column :surveys, :completed, :boolean
  end
end
