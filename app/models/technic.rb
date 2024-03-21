# == Schema Information
#
# Table name: technics
#
#  id              :uuid             not null, primary key
#  description     :text
#  image_alt       :string
#  image_credit    :string
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_technics_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_402a0ffef2  (published_by_id => users.id)
#
class Technic < ApplicationRecord
  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Searchable
  include Slugged
  include Structured

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :authors, class_name: 'User', join_table: "technics_users", association_foreign_key: :user_id

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
    where("unaccent(technics.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
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
