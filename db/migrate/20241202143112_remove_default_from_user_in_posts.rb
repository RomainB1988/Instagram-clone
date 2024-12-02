class RemoveDefaultFromUserInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_default :posts, :user_id, from: 1, to: nil
  end
end
