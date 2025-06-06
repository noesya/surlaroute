# == Schema Information
#
# Table name: subscriptions
#
#  id                                   :uuid             not null, primary key
#  expiration_date                      :date
#  helloasso_checkout_intent_identifier :bigint
#  helloasso_order_identifier           :bigint
#  paid_amount                          :decimal(, )
#  paid_at                              :datetime
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  product_id                           :uuid             not null, indexed
#  user_id                              :uuid             not null, indexed
#
# Indexes
#
#  index_subscriptions_on_product_id  (product_id)
#  index_subscriptions_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_52a3b81fce  (product_id => products.id)
#  fk_rails_933bdff476  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :product

  before_validation :set_expiration_date, on: :create

  scope :active, -> { where('expiration_date > ?', Time.zone.now) }
  scope :ordered, -> { order(created_at: :desc) }

  def reference
    "##{helloasso_order_identifier}"
  end

  def expiration_date_to_display
    return nil if expiration_date.nil?
    expiration_date - 1.day
  end

  def to_s
    "#{reference} - #{user} - #{product}"
  end

  def set_expiration_date
    # paid_at = 25/03/2024 à 18h34 ; expiration_date = 25/03/2025
    self.expiration_date = self.paid_at.to_date + 1.year
  end
end
