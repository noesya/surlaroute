# == Schema Information
#
# Table name: projects
#
#  id           :uuid             not null, primary key
#  description  :text
#  image_alt    :string
#  image_credit :string
#  name         :string
#  published    :boolean          default(FALSE)
#  slug         :string           indexed
#  status       :integer          default("draft")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_projects_on_slug  (slug) UNIQUE
#
class Project < ApplicationRecord
  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Searchable
  include Slugged
  include Structured

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :technics
  has_and_belongs_to_many :authors, class_name: 'User', join_table: "projects_users", association_foreign_key: :user_id

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  has_one_attached_deletable :image

  attr_accessor :acceptance

  validates_presence_of :name
  validates_acceptance_of :acceptance, on: :create

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
    where("unaccent(projects.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }
  scope :autofilter_published, -> (status) { where(published: status) }

  def has_brezet_wheel?
    answers.where(value: true).exists?
  end

  def to_s
    "#{name}"
  end

  protected

  def search_data
    {
      name: name,
      description: description,
      published: published,
      structure_values: searchable_text_from_structure_values,
      answers: searchable_text_from_answers
    }
  end

  def searchable_text_from_answers
    raw_texts_from_answers = answers.where(value: true).pluck(:text).compact
    CustomSanitizer.sanitize(raw_texts_from_answers.join(' '), 'string')
  end
end
