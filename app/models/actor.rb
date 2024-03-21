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
#  lab_member            :boolean          default(FALSE)
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
  include Searchable
  include Slugged
  include Structured
  include WithGeolocation

  attr_accessor :sort_order

  has_and_belongs_to_many :materials
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :technics
  has_and_belongs_to_many :authors, class_name: 'User', join_table: "actors_users", association_foreign_key: :user_id

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :sort_order, -> { order(:name) }
  scope :ordered, -> { order(:name) }
  scope :ordered_by_creation_date, -> { order(created_at: :desc) }
  scope :premium, -> { where(premium: true) }
  scope :lab_member, -> { where(lab_member: true) }
  scope :with_contact_informations, -> { where.not(contact_name: [nil, ''], contact_email: [nil, ''], contact_phone: [nil, ''], contact_website: [nil, ''], contact_inventory_url: [nil, '']) }
  scope :order_by, -> (order_param) {
    case order_param
    when "name:asc"
      order(name: :asc)
    when "name:desc"
      order(name: :desc)
    when "date:asc"
      order(created_at: :asc)
    when "date:desc"
      order(created_at: :desc)
    else
      all
    end
  }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(actors.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }
  scope :autofilter_published, -> (status) { where(published: status) }
  scope :autofilter_premium, -> (status) { where(premium: status) }

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

  protected

  def search_data
    {
      name: name,
      description: description,
      full_address: full_address,
      contact_email: contact_email,
      contact_inventory_url: contact_inventory_url,
      contact_name: contact_name,
      contact_phone: contact_phone,
      contact_website: contact_website,
      service_access_terms: service_access_terms,
      structure_values: searchable_text_from_structure_values
    }
  end
end
