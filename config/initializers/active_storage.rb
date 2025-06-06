Rails.application.config.to_prepare do
  ActiveStorage::Engine.config.active_storage.content_types_to_serve_as_binary.delete('image/svg+xml')

  # Override ActiveStorage::Filename#sanitized to remove accents and all special chars
  # Base method: https://github.com/rails/rails/blob/v7.0.3/activestorage/app/models/active_storage/filename.rb#L57
  ActiveStorage::Filename.class_eval do
    def sanitized
      base_filename = base.encode(Encoding::UTF_8, invalid: :replace, undef: :replace, replace: "�")
                          .strip
                          .tr("\u{202E}%$|:;/\t\r\n\\", "-")
                          .parameterize(preserve_case: true)
      [base_filename, extension_with_delimiter].join('')
    end
  end

  module ActiveStorageBlobUserLogsConcern
    extend ActiveSupport::Concern

    included do
      has_many :user_logs, class_name: "User::Log", dependent: :nullify
    end
  end
  ActiveStorage::Blob.include ActiveStorageBlobUserLogsConcern
end
