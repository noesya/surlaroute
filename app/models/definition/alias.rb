# frozen_string_literal: true

# == Schema Information
#
# Table name: definition_aliases
#
#  id            :uuid             not null, primary key
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  definition_id :uuid             not null, indexed
#
# Indexes
#
#  index_definition_aliases_on_definition_id  (definition_id)
#
# Foreign Keys
#
#  fk_rails_0d853ffb92  (definition_id => definitions.id)
#
class Definition::Alias < ApplicationRecord

  belongs_to :definition
  
  scope :ordered, -> { order(:title) }
  
  validates :title, presence: true, uniqueness: true
  validate :title_not_used_by_definition

  def to_s
    "#{title}"
  end

  private

  def title_not_used_by_definition
    self.errors.add(:title, :taken_by_definition) if Definition.where(title: self.title).exists?
  end
  
end
