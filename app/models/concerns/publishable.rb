module Publishable
  extend ActiveSupport::Concern

  included do
    enum status: {
      draft: 0,
      rejected: 10,
      waiting_for_attribution: 20,
      redaction_in_progress: 30,
      missing_informations: 40,
      waiting_for_approval: 50,
      validated: 60,
      manufacturer: 70,
      published: 80
    }
    scope :published, -> { where(published: true) }
    scope :draft, -> { where(published: false) }
    scope :autofilter_status, -> (status) { where(status: status) }
  end

end
