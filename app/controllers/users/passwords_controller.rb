class Users::PasswordsController < Devise::PasswordsController
  def update
    super
    enforce_two_factor_authentication
  end
end
