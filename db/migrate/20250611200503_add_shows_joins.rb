class AddShowsJoins < ActiveRecord::Migration[7.2]
  def change
    create_table :tour_shows_users, id: false do |t|
      t.references :show, null: false, foreign_key: {to_table: :tour_shows}, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.index [:show_id, :user_id]
      t.index [:user_id, :show_id]
    end
    create_table :regions_tour_shows, id: false do |t|
      t.references :show, null: false, foreign_key: {to_table: :tour_shows}, type: :uuid
      t.references :region, null: false, foreign_key: true, type: :uuid

      t.index [:show_id, :region_id]
      t.index [:region_id, :show_id]
    end
  end
end
