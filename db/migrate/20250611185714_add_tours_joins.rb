class AddToursJoins < ActiveRecord::Migration[7.2]
  def change
    create_join_table :tours, :users, column_options: {type: :uuid} do |t|
      t.index [:tour_id, :user_id]
    end
    create_join_table :regions, :tours, column_options: {type: :uuid} do |t|
      t.index [:tour_id, :region_id]
      t.index [:region_id, :tour_id]
    end
  end
end
