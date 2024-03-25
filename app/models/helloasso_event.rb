# == Schema Information
#
# Table name: helloasso_events
#
#  id         :uuid             not null, primary key
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class HelloassoEvent < ApplicationRecord
  after_commit :enqueue_handling, on: :create

  def handle
    checkout_intent_identifier = data.dig('data', 'checkoutIntentId')
    order_id = data.dig('data', 'id')
    user_id = data.dig('metadata', 'user_id')
    product_id = data.dig('metadata', 'product_id')
    paid_amount = data.dig('data', 'amount', 'total') / 100.0
    payments = data.dig('data', 'payments') || []
    payment = payments.first
    paid_at = Time.parse(payment['date'])

    Subscription.create(
      helloasso_checkout_intent_identifier: checkout_intent_identifier,
      helloasso_order_identifier: order_id,
      paid_amount: paid_amount,
      paid_at: paid_at,
      product_id: product_id,
      user_id: user_id
    )
  end

  protected

  def enqueue_handling
    Helloasso::EventHandlerJob.perform_later(self)
  end
end
