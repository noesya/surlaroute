# == Schema Information
#
# Table name: regions
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Region < ApplicationRecord
  include WithSlug

  has_many :materials
  has_many :projects

  scope :ordered, -> { order(:name) }

  validates_presence_of :name

  has_one_attached_deletable :image

  def to_s
    "#{name}"
  end
end
