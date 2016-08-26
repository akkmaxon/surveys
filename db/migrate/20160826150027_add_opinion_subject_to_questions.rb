class AddOpinionSubjectToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :opinion_subject, :string
  end
end
