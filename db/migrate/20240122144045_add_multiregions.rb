class AddMultiregions < ActiveRecord::Migration[7.1]
  def change
    create_join_table :actors, :regions, column_options: {type: :uuid} do |t|
      t.index [:actor_id, :region_id]
      t.index [:region_id, :actor_id]
    end
    create_join_table :materials, :regions, column_options: {type: :uuid} do |t|
      t.index [:material_id, :region_id]
      t.index [:region_id, :material_id]
    end
    create_join_table :projects, :regions, column_options: {type: :uuid} do |t|
      t.index [:project_id, :region_id]
      t.index [:region_id, :project_id]
    end
    remove_column :actors, :region_id, :uuid
    remove_column :materials, :region_id, :uuid
    remove_column :projects, :region_id, :uuid
  end
end
