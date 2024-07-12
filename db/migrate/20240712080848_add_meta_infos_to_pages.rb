class AddMetaInfosToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_description, :text
  end
end
