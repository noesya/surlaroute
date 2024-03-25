class Subscription::ExpirationCheckJob < ApplicationJob
  def perform
    Subscription.includes(:user).where(expiration_date: Date.today).find_each do |subscription|
      user = subscription.user
      next if user.active_subscription.present?
      user.update(role: :visitor)
      UserMailer.with(user: user).expired_subscription.deliver_later
    end
  end
end
