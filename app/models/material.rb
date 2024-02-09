# == Schema Information
#
# Table name: materials
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string           indexed
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  actor_id        :uuid             indexed
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_materials_on_actor_id         (actor_id)
#  index_materials_on_published_by_id  (published_by_id)
#  index_materials_on_slug             (slug)
#
# Foreign Keys
#
#  fk_rails_d5f504ce55  (published_by_id => users.id)
#  fk_rails_e6f2c9950b  (actor_id => actors.id)
#
class Material < ApplicationRecord
  include Publishable
  include Regional
  include Slugged
  include Structured

  belongs_to :actor, optional: true
  has_and_belongs_to_many :projects
  
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
