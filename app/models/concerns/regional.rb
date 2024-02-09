module Regional
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :regions
  end

end
