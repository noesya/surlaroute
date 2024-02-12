class CreateStructureValueFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :structure_value_files, id: :uuid do |t|
      t.references :value, null: false, foreign_key: { to_table: :structure_values }, type: :uuid

      t.timestamps
    end

    ActiveStorage::Attachment.where(record_type: "Structure::Value").each do |attachment|
      value = attachment.record
      value_file = value.files.create
      attachment.update_columns(record_type: "Structure::Value::File", record_id: value_file.id)
    end
  end
end
