# == Schema Information
#
# Table name: regions
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string           indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_regions_on_slug  (slug) UNIQUE
#
class Region < ApplicationRecord
  include Slugged

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :projects

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :ordered, -> { order(:name) }

  def to_s
    "#{name}"
  end
end
