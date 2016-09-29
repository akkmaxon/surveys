class AddAudienceToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :audience, :string, default: "Менеджмент"
  end
end
