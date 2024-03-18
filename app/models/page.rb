# == Schema Information
#
# Table name: pages
#
#  id                  :uuid             not null, primary key
#  body_class          :string           default("")
#  description         :text
#  in_lab_tree         :boolean          default(FALSE)
#  in_toolbox_tree     :boolean          default(FALSE)
#  internal_identifier :string
#  name                :string           not null
#  path                :string           not null
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

  LAB_INTERNAL_IDENTIFIER = 'le-lab'
  TOOLBOX_INTERNAL_IDENTIFIER = 'boite-a-outils'

  include Searchable
  include WithTree

  has_many :blocks, dependent: :destroy
  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: :parent_id, dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  before_validation :set_body_class, :set_path, :check_ancestor_tree
  after_save :update_children_paths, if: :saved_change_to_path?

  scope :ordered, -> { order(:name) }
  scope :ordered_by_position, -> { order(:position, :name) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(pages.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def self.lab
    @@lab ||= find_by(internal_identifier: LAB_INTERNAL_IDENTIFIER)
  end

  def self.toolbox
    @@toolbox ||= find_by(internal_identifier: TOOLBOX_INTERNAL_IDENTIFIER)
  end

  def generated_path
    ancestors.any? ? "#{ancestors.pluck(:slug).join('/')}/#{slug}"
                   : slug
  end

  def is_lab?
    internal_identifier == LAB_INTERNAL_IDENTIFIER
  end

  def to_s
    "#{name}"
  end

  private

  def set_body_class
    self.body_class = 'toolbox-index' if internal_identifier == 'boite-a-outils'
    self.body_class = 'laboratory-index' if internal_identifier == 'le-lab'
    self.body_class = 'toolbox-child' if ancestors.pluck(:internal_identifier).include?('boite-a-outils')
    self.body_class = 'laboratory-child' if ancestors.pluck(:internal_identifier).include?('le-lab')
  end

  def set_path
    self.path = generated_path
  end

  def update_children_paths
    descendants.each do |child|
      child.update_column :path, child.generated_path
    end
  end

  def check_ancestor_tree
    in_lab_tree = ancestors_and_self.detect { |ancestor| ancestor == Page.lab }
    in_toolbox_tree = ancestors_and_self.detect { |ancestor| ancestor == Page.toolbox }
  end

end
