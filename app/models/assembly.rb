# == Schema Information
#
# Table name: assemblies
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_assemblies_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_402a0ffef2  (published_by_id => users.id)
#
class Assembly < ApplicationRecord
  include WithPublisher
  include WithSlug
  include WithStructure

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
