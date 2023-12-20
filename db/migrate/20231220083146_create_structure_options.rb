class CreateStructureOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :structure_options, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.text :hint
      t.integer :position
      t.references :item, null: false, foreign_key: {to_table: :structure_items}, type: :uuid

      t.timestamps
    end
  end
end
