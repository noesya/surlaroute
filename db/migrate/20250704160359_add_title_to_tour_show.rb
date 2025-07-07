class AddTitleToTourShow < ActiveRecord::Migration[8.0]
  def change
    add_column :tour_shows, :title, :string
  end
end
