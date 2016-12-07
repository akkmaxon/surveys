class AddOpinionSubjectToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :opinion_subject, :string
  end
end
