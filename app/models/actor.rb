# == Schema Information
#
# Table name: actors
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
#  index_actors_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_666a0f2abc  (published_by_id => users.id)
#
class Actor < ApplicationRecord
  include WithPublisher
  include WithRegions
  include WithSlug
  include WithStructure

  has_many :materials
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
