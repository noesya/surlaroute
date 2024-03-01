class AddColorToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_items, :color, :string
  end
end
