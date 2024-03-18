module Regional
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :regions

    scope :autofilter_region, -> (region_ids) { joins(:regions).where(regions: region_ids) }
  end

end
