class AddZoneToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_items, :zone, :integer, default: 3
  end
end
