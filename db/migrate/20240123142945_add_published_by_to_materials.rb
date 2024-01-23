class AddPublishedByToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_reference :actors, :published_by, foreign_key:  {to_table: :users}, type: :uuid
    add_reference :materials, :published_by, foreign_key: {to_table: :users}, type: :uuid
    add_reference :projects, :published_by, foreign_key: {to_table: :users}, type: :uuid
  end
end
