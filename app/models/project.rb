# == Schema Information
#
# Table name: projects
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string           indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#
class Project < ApplicationRecord
  include WithRegions
  include WithSlug
  include WithStructure

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
