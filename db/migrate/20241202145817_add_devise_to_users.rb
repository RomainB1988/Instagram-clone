class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def up
    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      # Supprime ou ajuste cette ligne si `email` existe déjà
      # t.string :email, null: false, default: "" unless column_exists?(:users, :email)

      # Si tu utilises la confirmation d'email ou d'autres fonctionnalités :
      # t.string :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string :unconfirmed_email
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true
  end

  def down
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
    end
  end
end
