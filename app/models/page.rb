# == Schema Information
#
# Table name: pages
#
#  id                  :uuid             not null, primary key
#  body_class          :string           default("")
#  description         :text
#  internal_identifier :string
#  name                :string
#  path                :string
#  position            :integer
#  slug                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  parent_id           :uuid             indexed
#
# Indexes
#
#  index_pages_on_parent_id  (parent_id)
#
# Foreign Keys
#
#  fk_rails_409bbac70a  (parent_id => pages.id)
#
class Page < ApplicationRecord

  include WithTree

  has_many :blocks
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: :parent_id, dependent: :destroy

  before_validation :set_body_class
  
  scope :ordered, -> { order(:name) }
  scope :ordered_by_position, -> { order(:position) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(pages.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def children
    Page.where(parent_id: id).ordered_by_position
  end

  def to_s
    "#{name}"
  end

  def to_param
    path
  end

  def calculated_path
    parent.present? ? "#{parent.path}/#{path}" : path
  end

  private

  def set_body_class
    self.body_class = 'toolbox-index' if internal_identifier == 'boite-a-outils'
    self.body_class = 'laboratory-index' if internal_identifier == 'le-lab'
    self.body_class = 'toolbox-child' if ancestors.pluck(:internal_identifier).include?('boite-a-outils')
    self.body_class = 'laboratory-child' if ancestors.pluck(:internal_identifier).include?('le-lab')
  end

end
