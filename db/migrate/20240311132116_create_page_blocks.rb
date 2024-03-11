class CreatePageBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :page_blocks, id: :uuid do |t|
      t.references :page, null: false, foreign_key: true, type: :uuid
      t.integer :kind, default: 1
      t.integer :position, default: 1
      t.jsonb :data

      t.timestamps
    end
  end
end
