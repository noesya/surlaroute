class CreateRegionsTechnicsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :regions, :technics, column_options: {type: :uuid} do |t|
      t.index [:region_id, :technic_id]
      t.index [:technic_id, :region_id]
    end
  end
end
