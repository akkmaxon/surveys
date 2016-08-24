class AddUserAgreementToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :user_agreement, :string, default: ""
  end
end
