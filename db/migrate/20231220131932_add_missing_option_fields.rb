class AddMissingOptionFields < ActiveRecord::Migration[7.1]
  def change
    add_reference :structure_values, :option, null: true, foreign_key: {to_table: :structure_options}, type: :uuid
    add_column :structure_items, :slug, :string
    add_index :projects, :slug, unique: true
    add_index :regions, :slug, unique: true
  end
end
