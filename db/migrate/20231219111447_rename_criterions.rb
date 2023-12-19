class RenameCriterions < ActiveRecord::Migration[7.1]
  def change
    rename_table :criterions, :structure_items
    rename_table :criterion_values, :structure_values
    rename_column :structure_values, :criterion_id, :item_id
  end
end
