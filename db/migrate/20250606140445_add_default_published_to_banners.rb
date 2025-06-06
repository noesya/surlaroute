class AddDefaultPublishedToBanners < ActiveRecord::Migration[7.2]
  def change
    change_column_default :banners, :published, from: nil, to: false
  end
end
