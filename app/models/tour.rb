# == Schema Information
#
# Table name: tours
#
#  id           :uuid             not null, primary key
#  image_alt    :string
#  image_credit :string
#  name         :string
#  published    :boolean          default(FALSE)
#  slug         :string
#  status       :integer          default("draft")
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Tour < ApplicationRecord
  include Commentable
  include Favoritable
  include Loggable
  include Orderable
  include Publishable
  include Regional
  include Searchable
  include Slugged
  include Structured

  has_and_belongs_to_many :authors, class_name: 'User', join_table: "tours_users", association_foreign_key: :user_id

  has_one_attached_deletable :image
  has_one_attached_deletable :logo

  validates_presence_of :name, :year

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(tours.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
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
      published: published,
      structure_values: searchable_text_from_structure_values
    }
  end
end
