class CreateTourShows < ActiveRecord::Migration[7.2]
  def change
    create_table :tour_shows, id: :uuid do |t|
      t.references :tour, null: false, foreign_key: true, type: :uuid
      t.references :place, null: false, foreign_key: {to_table: :actors}, type: :uuid
      t.boolean :published, default: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
