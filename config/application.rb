require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecotheque
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = 'Europe/Paris'
    config.active_storage.service_urls_expire_in = 1.hour

    config.sass.preferred_syntax = :sass

    config.i18n.available_locales = [:fr]
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = [::I18n.default_locale]
    config.i18n.enforce_available_locales = false
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.yml"]

    config.internal_domains = ['@noesya.coop', '@boissinot.paris'].freeze

    config.active_job.queue_adapter = :good_job

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        address: "smtp-relay.brevo.com",
        port: 587,
        user_name: ENV['SMTP_USER'],
        password: ENV['SMTP_PASSWORD'],
        authentication: :plain
    }

    # Need for +repage, because of https://github.com/rails/rails/commit/b2ab8dd3a4a184f3115e72b55c237c7b66405bd9
    config.active_storage.supported_image_processing_methods = ["+"]
    # TODO Remove when kamifusen is compatible with Vips
    config.active_storage.variant_processor = :mini_magick

    config.action_view.sanitizer_vendor = Rails::HTML4::Sanitizer
    config.action_view.sanitized_allowed_tags = [
      "h3", "a", "b", "br", "em", "i", "img", "li", "ol", "p", "strong", "sub", "sup", "ul"
    ]
    config.action_view.sanitized_allowed_attributes = [
      "href", "target", "title", "data-bs-toggle"
    ]

    config.allowed_special_chars = '#?!,_@$%^&*+:;£µ-'

    config.default_images_formats = ['.jpg', '.jpeg', '.png', '.svg']
    config.default_image_max_size = 5.megabytes


    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

  end
end
