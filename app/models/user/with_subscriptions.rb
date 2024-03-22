module User::WithSubscriptions
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, dependent: :destroy
  end

  def update_role_from_subscriptions!
    # We don't change the role for lab members or (super)admins.
    if visitor? || subscriber?
      new_role = subscriptions.active.exists? ? :subscriber : :visitor
      update(role: new_role)
    end
  end
end
