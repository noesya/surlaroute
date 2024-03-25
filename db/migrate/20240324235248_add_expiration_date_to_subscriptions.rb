class AddExpirationDateToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :expiration_date, :date
  end
end
