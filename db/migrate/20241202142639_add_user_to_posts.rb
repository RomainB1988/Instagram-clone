class AddUserToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :user, null: false, foreign_key: true, default: 1
  end
end
