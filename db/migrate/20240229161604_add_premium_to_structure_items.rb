class AddPremiumToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_items, :premium, :boolean, default: false
  end
end
