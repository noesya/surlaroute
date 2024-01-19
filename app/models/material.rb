# == Schema Information
#
# Table name: materials
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string           indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  actor_id    :uuid             indexed
#  region_id   :uuid             indexed
#
# Indexes
#
#  index_materials_on_actor_id   (actor_id)
#  index_materials_on_region_id  (region_id)
#  index_materials_on_slug       (slug)
#
# Foreign Keys
#
#  fk_rails_e6f2c9950b  (actor_id => actors.id)
#
class Material < ApplicationRecord
  include WithSlug
  include WithStructure

  belongs_to :region, optional: true
  belongs_to :actor, optional: true
  
  has_one_attached_deletable :image

  validates_presence_of :name

  scope :ordered, -> { order(:name) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(materials.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def to_s
    "#{name}"
  end
end
