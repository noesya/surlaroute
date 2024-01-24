class CreateAssemblies < ActiveRecord::Migration[7.1]
  def change
    create_table :assemblies, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.references :published_by, foreign_key: {to_table: :users}, type: :uuid

      t.timestamps
    end
    create_join_table :assemblies, :projects, column_options: {type: :uuid} do |t|
      t.index [:assembly_id, :project_id]
      t.index [:project_id, :assembly_id]
    end
  end
end
