class AddContactInfoToActors < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :service_access_terms, :text

    add_column :actors, :address, :string
    add_column :actors, :address_additional, :string
    add_column :actors, :zipcode, :string
    add_column :actors, :city, :string
    add_column :actors, :country, :string
    add_column :actors, :latitude, :decimal
    add_column :actors, :longitude, :decimal

    add_column :actors, :contact_name, :string
    add_column :actors, :contact_email, :string
    add_column :actors, :contact_phone, :string
    add_column :actors, :contact_website, :string
    add_column :actors, :contact_inventory_url, :string
  end
end
