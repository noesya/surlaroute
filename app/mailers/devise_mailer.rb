class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    super if should_send?(record.email)
  end

  def reset_password_instructions(record, token, opts={})
    super if should_send?(record.email)
  end

  def unlock_instructions(record, token, opts={})
    super if should_send?(record.email)
  end

  def email_changed(record, opts={})
    super if should_send?(record.email)
  end

  def password_change(record, opts={})
    super if should_send?(record.email)
  end

  def two_factor_authentication_code(record, code, opts = {})
    @code = code
    @duration =  ActiveSupport::Duration.build(Rails.application.config.devise.direct_otp_valid_for).inspect
    devise_mail(record, :two_factor_authentication_code, opts) if should_send?(record.email)
  end

end
