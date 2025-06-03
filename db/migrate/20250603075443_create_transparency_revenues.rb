class CreateTransparencyRevenues < ActiveRecord::Migration[7.2]
  def change
    create_table :transparency_revenues, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.references :transparency_year, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
