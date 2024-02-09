module Publishable
  extend ActiveSupport::Concern

  included do
    belongs_to :published_by, class_name: 'User', optional: true

    scope :published, -> { where(published: true) }
    scope :draft, -> { where(published: false) }
  end

end
