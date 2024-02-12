class CreateStructureOptionValueJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :structure_options_values, id: false do |t|
      t.references :option, null: false, foreign_key: { to_table: :structure_options }, type: :uuid
      t.references :value, null: false, foreign_key: { to_table: :structure_values }, type: :uuid
    end

    item_ids = Structure::Item.where(kind: Structure::Item::KINDS_WITH_OPTIONS).pluck(:id)
    values_count_per_about_and_item = Structure::Value.where(item_id: item_ids).group(:about_type, :about_id, :item_id).count
    keys = values_count_per_about_and_item.keys
    # [ ["Actor", "f4f55daf-e118-490b-b12b-34d950dec914", "7a69dfa7-1ccd-4946-9e85-fe0b14480cd8"], ... ]
    keys.each do |key|
      # Better variable names
      about_type, about_id, item_id = key
      values_scope = Structure::Value.where(about_type: about_type, about_id: about_id, item_id: item_id)
      # Get text from first value
      value_text = values_scope.first.text
      # Get all IDs to be destroyed
      value_ids = values_scope.pluck(:id)
      # Get all IDs of the selected options
      option_ids = values_scope.pluck(:option_id).compact.uniq
      # Create a new value with all the options inside
      new_value = Structure::Value.create(about_type: about_type, about_id: about_id, item_id: item_id, text: value_text)
      new_value.option_ids = option_ids
      # Remove legacy values
      Structure::Value.where(id: value_ids).destroy_all
    end

    remove_reference :structure_values, :option, type: :uuid, index: true, foreign_key: { to_table: :structure_options }
  end
end
