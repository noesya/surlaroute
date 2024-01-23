module WithPublisher
  extend ActiveSupport::Concern

  included do
    belongs_to :published_by, class_name: 'User'
  end

end
