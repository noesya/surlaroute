class AddFieldsToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_items, :show_in_list, :boolean, default: false
    add_column :structure_items, :show_label, :boolean, default: true
  end
end
