class RenameAssembliesTechnics < ActiveRecord::Migration[7.1]
  def change
    rename_table :assemblies, :technics
    rename_table :assemblies_projects, :projects_technics
    rename_column :projects_technics, :assembly_id, :technic_id
  end
end
