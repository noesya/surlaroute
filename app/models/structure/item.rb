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
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Structure::Item < ApplicationRecord
  include WithSlug

  ABOUT_CLASSES = [
    Material,
    Actor,
    Project
  ]

  has_many :values, dependent: :destroy
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name

  before_create :set_position

  scope :ordered, -> { order(:position) }

  enum kind: {
    string: 0,
    text: 1,
    url: 2,
    option: 11,
    options: 12,
    file: 21,
    h2: 102
  }, _prefix: :kind

  def self.with_options
    [
      'option',
      'options'
    ]
  end


  def has_options?
    kind.in?(Structure::Item.with_options)
  end

  def save_value(object, data)
    has_options?  ? connect_options(object, data)
                  : save_data(object, data)
  end

  def values_for(object)
    values.where(about: object)
  end

  def value_for(object)
    values_for(object).first_or_create
  end

  def text_for(object)
    value_for(object).text
  end

  def options_for(object)
    values_for(object).collect(&:option).compact
  end

  def option_for(object)
    value_for(object)&.option
  end

  def selected_option?(object, option)
    option.in? options_for(object)
  end

  def to_s
    "#{name}"
  end

  protected

  def connect_options(object, id_or_ids)
    values_for(object).destroy_all
    return if id_or_ids.blank?
    if id_or_ids.is_a?(String)
      connect_option(object, id_or_ids)
    else
      id_or_ids.compact.each do |id|
        connect_option(object, id)
      end
    end
  end

  def connect_option(object, id)
    values_for(object).where(option_id: id).first_or_create
  end

  def save_data(object, data)
    value = value_for(object)
    value.save_data(data)
  end

  def set_position
    last_higher_position = Structure::Item.where(about_class: about_class).maximum(:position) || 0
    self.position = last_higher_position + 1
  end
end
