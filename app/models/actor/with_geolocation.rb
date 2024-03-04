module Actor::WithGeolocation
  extend ActiveSupport::Concern

  included do
    geocoded_by :full_address

    validates :address, :zipcode, :city, :country, presence: true

    after_validation :geocode, if: -> (geocodable) { geocodable.full_address_present? && geocodable.full_address_changed?
  end

  def full_address
    [address, zipcode, city, country].join
  end

  def full_address_present?
    address.present? || zipcode.present? || city.present?
  end

  def full_address_changed?
    address_changed? || zipcode_changed? || city_changed? || country_changed?
  end
end