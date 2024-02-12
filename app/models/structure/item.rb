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
  include Positionable # last_ordered_element is overwritten
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

  scope :with_options, -> { where(kind: Structure::Item::KINDS_WITH_OPTIONS) }

  enum kind: {
    string: 0,
    text: 1,
    url: 2,
    option: 11,
    options: 12,
    colors: 13,
    file: 21,
    images: 24,
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
    value_for(object).options
  end

  def option_for(object)
    options_for(object).first
  end

  def selected_option?(object, option)
    option.in? options_for(object)
  end

  def files_for(object)
    value_for(object).files
  end

  def file_for(object)
    files_for(object).first
  end

  def to_s
    "#{name}"
  end

  protected

  def last_ordered_element
    Structure::Item.where(about_class: about_class).ordered.last
  end
end
