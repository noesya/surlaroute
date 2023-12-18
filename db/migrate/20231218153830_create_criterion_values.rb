class CreateCriterionValues < ActiveRecord::Migration[7.1]
  def change
    create_table :criterion_values, id: :uuid do |t|
      t.text :text
      t.references :about, polymorphic: true, null: false, type: :uuid
      t.references :criterion, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
