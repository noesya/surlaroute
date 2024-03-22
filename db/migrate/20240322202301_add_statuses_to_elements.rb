class AddStatusesToElements < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :status, :integer, default: 0
    add_column :projects, :status, :integer, default: 0
    add_column :technics, :status, :integer, default: 0
    add_column :materials, :status, :integer, default: 0
  end
end
