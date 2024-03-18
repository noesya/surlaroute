# frozen_string_literal: true

# == Schema Information
#
# Table name: definitions
#
#  id         :uuid             not null, primary key
#  text       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Definition < ApplicationRecord

  has_many :aliases, dependent: :destroy
  accepts_nested_attributes_for :aliases, allow_destroy: true

  scope :ordered, -> { order(:title) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (search) { 
    joins(:aliases).where("unaccent(definitions.title) ILIKE unaccent(:term) OR unaccent(definition_aliases.title) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(search)}%").distinct
  }

  validates :title, :text, presence: true
  validates :title, uniqueness: true
  validate :title_not_used_by_alias

  def to_s
    "#{title}"
  end

  private

  def title_not_used_by_alias
    self.errors.add(:title, :taken_by_alias) if Definition::Alias.where(title: self.title).exists?
  end
  
end
