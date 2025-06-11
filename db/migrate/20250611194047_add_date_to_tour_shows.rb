class AddDateToTourShows < ActiveRecord::Migration[7.2]
  def change
    add_column :tour_shows, :day, :date
  end
end
