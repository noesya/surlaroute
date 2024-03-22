class Subscription::ExpirationCheckJob < ApplicationJob
  def perform
    User.where(role: :subscriber).where(
      'NOT EXISTS (SELECT 1 FROM subscriptions WHERE subscriptions.user_id = users.id AND subscriptions.paid_at >= ?)', 1.year.ago
    ).find_each do |user|
      user.update(role: :visitor)
      UserMailer.with(user: user).expired_subscription.deliver_later
    end
  end
end
