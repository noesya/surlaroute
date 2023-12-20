# == Schema Information
#
# Table name: structure_items
#
#  id          :uuid             not null, primary key
#  about_class :string
#  hint        :text
#  kind        :integer          default("string")
#  name        :string
#  position    :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Structure::Item < ApplicationRecord
  ABOUT_CLASSES = [
    Material,
    Project
  ]

  has_many :values

  validates_presence_of :name

  scope :ordered, -> { order(:position) }

  enum kind: {
    string: 0,
    text: 1,
    single_choice: 11,
    multiple_choices: 12, 
    heading_2: 102,
    heading_3: 103
  }, _prefix: :kind

  def to_s
    "#{name}"
  end
end
