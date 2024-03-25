class AddRedirectUrlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :redirect_url, :string
  end
end
