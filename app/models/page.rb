# == Schema Information
#
# Table name: pages
#
#  id                  :uuid             not null, primary key
#  description         :text
#  internal_identifier :string
#  name                :string
#  path                :string
#  position            :integer
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
  belongs_to :parent, class_name: 'Page', optional: true
  
  scope :ordered, -> { order(:name) }
  scope :ordered_by_position, -> { order(:position) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(pages.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def to_s
    "#{name}"
  end

  def to_param
    path
  end

  def calculated_path
    parent.present? ? "#{parent.path}/#{path}" : path
  end

end
