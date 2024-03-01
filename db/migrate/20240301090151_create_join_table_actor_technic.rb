class CreateJoinTableActorTechnic < ActiveRecord::Migration[7.1]
  def change
    create_join_table :actors, :technics, column_options: {type: :uuid} do |t|
      t.index [:technic_id, :actor_id]
    end
  end
end
