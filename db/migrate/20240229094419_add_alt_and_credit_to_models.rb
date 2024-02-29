class AddAltAndCreditToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :actors,     :image_alt, :string
    add_column :actors,     :image_credit, :string

    add_column :assemblies, :image_alt, :string
    add_column :assemblies, :image_credit, :string

    add_column :materials,  :image_alt, :string
    add_column :materials,  :image_credit, :string

    add_column :projects,   :image_alt, :string
    add_column :projects,   :image_credit, :string

    add_column :regions,    :image_alt, :string
    add_column :regions,    :image_credit, :string
  end
end
