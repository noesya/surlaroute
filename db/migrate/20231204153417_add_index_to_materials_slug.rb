class AddIndexToMaterialsSlug < ActiveRecord::Migration[7.1]
  def change
    add_index :materials, :slug
  end
end
