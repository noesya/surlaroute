# == Schema Information
#
# Table name: structure_options
#
#  id         :uuid             not null, primary key
#  hint       :text
#  name       :string
#  position   :integer
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :uuid             not null, indexed
#
# Indexes
#
#  index_structure_options_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_1ce4c6dd6a  (item_id => structure_items.id)
#
class Structure::Option < ApplicationRecord
  include WithSlug

  belongs_to :item
  has_many :values, dependent: :destroy

  scope :ordered, -> { order(:position) }

  def objects
    item.about_class.constantize.where(id: objects_ids)
  end

  def to_s
    "#{name}"
  end

  protected

  def objects_ids
    values.pluck(:about_id)
  end
end
