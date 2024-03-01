class AddUsedToStructureItems < ActiveRecord::Migration[7.1]
  def change
    add_column :structure_options, :in_use, :boolean, default: false
    Structure::Item.where(about_class: 'Assembly').update_all(about_class: 'Technic')
    Structure::Option.all.each do |option|
      option.denormalize_in_use!
    end
  end
end
