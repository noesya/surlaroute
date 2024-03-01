# == Schema Information
#
# Table name: structure_options
#
#  id         :uuid             not null, primary key
#  hint       :text
#  in_use     :boolean          default(FALSE)
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
  include Positionable # last_ordered_element is overwritten
  include Slugged

  belongs_to :item
  has_and_belongs_to_many :values

  scope :ordered_by_name, -> { order(:name) }
  scope :in_use, -> { where(in_use: true) }

  def objects
    item.about_class.constantize.where(id: objects_ids)
  end

  def denormalize_in_use!
    self.update_column :in_use, objects.any?
  end

  def to_s
    "#{name}"
  end

  protected

  def objects_ids
    values.pluck(:about_id)
  end

  def last_ordered_element
    Structure::Option.where(item_id: item_id).ordered.last
  end
end
