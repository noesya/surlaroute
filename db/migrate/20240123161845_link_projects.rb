class LinkProjects < ActiveRecord::Migration[7.1]
  def change
    create_join_table :actors, :projects, column_options: {type: :uuid} do |t|
      t.index [:actor_id, :project_id]
      t.index [:project_id, :actor_id]
    end
    create_join_table :materials, :projects, column_options: {type: :uuid} do |t|
      t.index [:material_id, :project_id]
      t.index [:project_id, :material_id]
    end
  end
end
