class AddDecryptedPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :decrypted_password, :string
  end
end
