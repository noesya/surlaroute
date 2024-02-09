class AddPublication < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :published, :boolean, default: false
    add_column :assemblies, :published, :boolean, default: false
    add_column :materials, :published, :boolean, default: false
    add_column :projects, :published, :boolean, default: false
  end
end
