class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages, id: :uuid do |t|
      t.string :name, null: :false
      t.string :path, null: :false
      t.text :description
      t.string :internal_identifier
      t.integer :position
      t.references :parent, foreign_key: { to_table: :pages }, type: :uuid
      t.timestamps
    end
  end
end
