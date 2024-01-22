class AddWithExplanationToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_items, :with_explanation, :boolean, default: true
  end
end
