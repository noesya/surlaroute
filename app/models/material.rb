# == Schema Information
#
# Table name: materials
#
#  id              :uuid             not null, primary key
#  description     :text
#  image_alt       :string
#  image_credit    :string
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
  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Searchable
  include Slugged
  include Structured

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :authors, class_name: 'User', join_table: "materials_users", association_foreign_key: :user_id

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :ordered, -> { order(:name) }
  scope :ordered_by_creation_date, -> { order(created_at: :desc) }
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
    where("unaccent(materials.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }
  scope :autofilter_published, -> (status) { where(published: status) }

  def to_s
    "#{name}"
  end

  protected

  def search_data
    {
      name: name,
      description: description,
      structure_values: searchable_text_from_structure_values
    }
  end
end
