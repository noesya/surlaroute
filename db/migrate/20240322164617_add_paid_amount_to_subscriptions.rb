class AddPaidAmountToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :paid_amount, :decimal
  end
end
