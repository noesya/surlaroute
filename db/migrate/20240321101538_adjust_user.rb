class AdjustUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :allow_listing, :boolean, default: true
  end
end
