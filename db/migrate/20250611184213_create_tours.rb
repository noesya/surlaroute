class CreateTours < ActiveRecord::Migration[7.2]
  def change
    create_table :tours, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.string :website
      t.integer :year
      t.boolean :published, default: false
      t.integer :status, default: 0
      t.string :image_alt
      t.string :image_credit

      t.timestamps
    end
  end
end
