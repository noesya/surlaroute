class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_commit :update_user_role, on: :create

  scope :active, -> { where('paid_at >= ?', 1.year.ago) }

  def update_user_role
    user.update_role_from_subscriptions!
  end
end
