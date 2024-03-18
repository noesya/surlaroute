class CreateDefinitions < ActiveRecord::Migration[7.1]
  def change
    create_table :definitions, id: :uuid do |t|
      t.string "title", null: false
      t.text "text", null: false
      t.timestamps
    end
  end
end
