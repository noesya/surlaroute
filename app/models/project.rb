# == Schema Information
#
# Table name: projects
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
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_projects_on_published_by_id  (published_by_id)
#  index_projects_on_slug             (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_fef370b0dc  (published_by_id => users.id)
#
class Project < ApplicationRecord
  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Slugged
  include Structured

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :technics

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :ordered, -> { order(:name) }
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

  def has_brezet_wheel?
    answers.where(value: true).exists?
  end

  def to_s
    "#{name}"
  end
end
