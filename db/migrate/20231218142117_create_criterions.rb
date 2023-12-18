class CreateCriterions < ActiveRecord::Migration[7.1]
  def change
    create_table :criterions, id: :uuid do |t|
      t.string :name
      t.integer :kind, default: 0
      t.text :hint
      t.integer :position, default: 0
      t.string :about_class

      t.timestamps
    end
  end
end
