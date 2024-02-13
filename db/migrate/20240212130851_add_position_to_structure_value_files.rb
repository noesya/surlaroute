class AddPositionToStructureValueFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_value_files, :position, :integer

    Structure::Value.all.each do |value|
      value.files.order(:created_at).each_with_index do |file, index|
        file.update_column :position, index + 1
      end
    end
  end
end
