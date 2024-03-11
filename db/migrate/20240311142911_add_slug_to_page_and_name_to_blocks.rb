class AddSlugToPageAndNameToBlocks < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :slug, :string
    add_column :page_blocks, :name, :string
  end
end
