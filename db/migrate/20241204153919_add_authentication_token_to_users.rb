class AddAuthenticationTokenToUsers < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:users, :authentication_token)
      add_column :users, :authentication_token, :string, null: false, default: ''
      add_index :users, :authentication_token, unique: true
    end
  end
end
s
