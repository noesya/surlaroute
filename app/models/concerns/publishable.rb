module Publishable
  extend ActiveSupport::Concern

  included do
    enum status: {
      draft: 0
    }
    scope :published, -> { where(published: true) }
    scope :draft, -> { where(published: false) }
    scope :autofilter_status, -> (status) { where(status: status) }
  end

end
