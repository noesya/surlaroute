class RemovePublishedBy2 < ActiveRecord::Migration[7.1]
  def change
    remove_column :actors, :published_by_id
    remove_column :projects, :published_by_id
    remove_column :technics, :published_by_id
    remove_column :materials, :published_by_id
  end
end
