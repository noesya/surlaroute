module ApplicationController::WithBasicAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :http_basic_authentication
  end

  protected

  def http_basic_authentication
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end if ENV["BASIC_AUTH_USER"].present? && ENV["BASIC_AUTH_PASSWORD"].present?
  end
end