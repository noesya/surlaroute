class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.datetime :paid_at
      t.bigint :helloasso_checkout_intent_identifier
      t.bigint :helloasso_order_identifier

      t.timestamps
    end
  end
end
