# == Schema Information
#
# Table name: actors
#
#  id                    :uuid             not null, primary key
#  address               :string
#  address_additional    :string
#  city                  :string
#  contact_email         :string
#  contact_inventory_url :string
#  contact_name          :string
#  contact_phone         :string
#  contact_website       :string
#  country               :string
#  description           :text
#  image_alt             :string
#  image_credit          :string
#  latitude              :decimal(, )
#  longitude             :decimal(, )
#  name                  :string
#  premium               :boolean          default(FALSE)
#  published             :boolean          default(FALSE)
#  service_access_terms  :text
#  slug                  :string
#  zipcode               :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  published_by_id       :uuid             indexed
#
# Indexes
#
#  index_actors_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_666a0f2abc  (published_by_id => users.id)
#
class Actor < ApplicationRecord
  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Slugged
  include Structured
  include WithGeolocation

  attr_accessor :sort_order

  has_and_belongs_to_many :materials
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :technics

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :sort_order, -> { order(:name) }
  scope :ordered, -> { order(:name) }
  scope :premium, -> { where(premium: true) }
  scope :with_contact_informations, -> { where.not(contact_name: [nil, ''], contact_email: [nil, ''], contact_phone: [nil, ''], contact_website: [nil, ''], contact_inventory_url: [nil, '']) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(materials.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def full_address
    @full_address ||= [address, address_additional, city, zipcode, country].compact_blank.join(', ')
  end

  def has_any_contact_informations?
    # match with_contact_informations scope
    contact_name.present? || 
      contact_email.present? || 
      contact_phone.present? || 
      contact_website.present? ||
      contact_inventory_url.present? 
  end

  def to_s
    "#{name}"
  end
end
