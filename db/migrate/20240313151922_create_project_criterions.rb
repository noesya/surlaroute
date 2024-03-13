class CreateProjectCriterions < ActiveRecord::Migration[7.1]
  def change
    create_table :project_criterions, id: :uuid do |t|
      t.integer :step
      t.string :name
      t.text :hint

      t.timestamps
    end
  end
end
