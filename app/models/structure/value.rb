# == Schema Information
#
# Table name: structure_values
#
#  id         :uuid             not null, primary key
#  about_type :string           not null, indexed => [about_id]
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  about_id   :uuid             not null, indexed => [about_type]
#  item_id    :uuid             not null, indexed
#
# Indexes
#
#  index_criterion_values_on_about    (about_type,about_id)
#  index_structure_values_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_8490687e7c  (item_id => structure_items.id)
#
class Structure::Value < ApplicationRecord
  belongs_to :about, polymorphic: true
  belongs_to :item
  has_and_belongs_to_many :options
  has_many :files, dependent: :destroy

  accepts_nested_attributes_for :files, allow_destroy: true

  has_one_attached_deletable :file

  # Needed to execute before_validation callback on Structure::Value::File#file
  validates_associated :files

  def to_s
    options.any?  ? "#{options.ordered.map(&:to_s).join(', ')}"
                  : "#{text}"
  end
end
