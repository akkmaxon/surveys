class AddUserEmailToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :user_email, :string, default: "-"
  end
end
