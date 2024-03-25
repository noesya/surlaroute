module Helloasso::Api::WithRouting
  extend ActiveSupport::Concern

  included do
    include Rails.application.routes.url_helpers
  end

  def default_url_options
    { host: ENV["SITE_URL"] }
  end
end