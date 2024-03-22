# Preview all emails at http://localhost:3000/rails/mailers/user_mailer

class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/expired_subscription
  def expired_subscription
    UserMailer.with(user: User.superadmin.first).expired_subscription
  end

end
