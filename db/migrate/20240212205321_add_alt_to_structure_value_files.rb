class AddAltToStructureValueFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_value_files, :alt, :string
  end
end
