class AddStatusToUserComments < ActiveRecord::Migration[7.1]
  def change
    add_column :user_comments, :status, :integer, default: 1
  end
end
