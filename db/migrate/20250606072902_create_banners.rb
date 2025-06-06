class CreateBanners < ActiveRecord::Migration[7.2]
  def change
    create_table :banners, id: :uuid do |t|
      t.text :text
      t.string :background_color
      t.boolean :published
      t.timestamps
    end
  end
end
