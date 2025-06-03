class CreateTransparencyCosts < ActiveRecord::Migration[7.2]
  def change
    create_table :transparency_costs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.references :transparency_year, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
