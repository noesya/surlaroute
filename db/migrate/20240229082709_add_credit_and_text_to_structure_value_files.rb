class AddCreditAndTextToStructureValueFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_value_files, :credit, :string
    add_column :structure_value_files, :text, :string
  end
end
