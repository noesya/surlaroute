class AddWebsiteToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :website, :string
  end
end
