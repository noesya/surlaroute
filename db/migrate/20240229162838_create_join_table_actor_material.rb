class CreateJoinTableActorMaterial < ActiveRecord::Migration[7.1]
  def change
    create_join_table :actors, :materials, column_options: {type: :uuid} do |t|
      t.index [:material_id, :actor_id]
    end
  end
end
