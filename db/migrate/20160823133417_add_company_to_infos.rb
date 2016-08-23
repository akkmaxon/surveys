class AddCompanyToInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :infos, :company, :string, default: ""
  end
end
