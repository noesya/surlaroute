# == Schema Information
#
# Table name: structure_items
#
#  id               :uuid             not null, primary key
#  about_class      :string
#  hint             :text
#  kind             :integer          default("string")
#  name             :string
#  position         :integer          default(0)
#  slug             :string
#  with_explanation :boolean          default(TRUE)
#  zone             :integer          default("page")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Structure::Item < ApplicationRecord
  include Slugged

  ABOUT_CLASSES = [
    Material,
    Actor,
    Project,
    Assembly
  ]

  KINDS_WITH_OPTIONS = [
    'option',
    'options',
    'colors'
  ]

  has_many :values, dependent: :destroy
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name

  before_create :set_position

  scope :ordered, -> { order(:position) }
  scope :with_options, -> { where(kind: Structure::Item::KINDS_WITH_OPTIONS) }

  enum kind: {
    string: 0,
    text: 1,
    url: 2,
    option: 11,
    options: 12,
    colors: 13,
    file: 21,
    h2: 102
  }, _prefix: :kind

  enum zone: {
    title: 1,
    header: 2,
    page: 3
  }, _prefix: :zone

  def has_options?
    kind.in?(Structure::Item::KINDS_WITH_OPTIONS)
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

  def set_position
    last_higher_position = Structure::Item.where(about_class: about_class).maximum(:position) || 0
    self.position = last_higher_position + 1
  end
end
