class CreateDefinitionAliases < ActiveRecord::Migration[7.1]
  def change
    create_table :definition_aliases, id: :uuid do |t|
      t.references :definition, null: false, foreign_key: true, type: :uuid
      t.string "title", null: false
      t.timestamps
    end
  end
end
