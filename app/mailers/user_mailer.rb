class UserMailer < ApplicationMailer
  default template_path: 'mailers/users'

  def expired_subscription
    @user = params[:user]
    subject = "Abonnement annuel à l'écothèque expiré"
    mail(to: @user.email, subject: subject) if should_send?(@user.email)
  end

end
