class AddSourcesToAnnuaires < ActiveRecord::Migration[7.2]
  def change
    add_column :actors, :sources, :text
    add_column :projects, :sources, :text
    add_column :technics, :sources, :text
    add_column :materials, :sources, :text
  end
end
