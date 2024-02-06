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
  include WithSlug

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

  # Version option unique
  # {
  #   "option"=>"a27e43e3-fe31-41b3-a343-feb16ee0112a", 
  #   "text"=>"Explication des choix"
  # }
  # Version options multiples
  # {
  #   "options"=>[
  #     "", 
  #     "f02e70be-5d9a-40f2-ad35-f69b2f154c97", 
  #     "af141121-e0cf-4fe1-8235-fcd9373d76c6"
  #     ], 
  #   "text"=>"Texte pour brillant et opaque"
  # }
  def connect_options(object, hash)
    text = hash['text']
    values_for(object).destroy_all
    if hash.has_key?('option')
      connect_option(object, hash['option'], text)
    else
      hash['options'].compact.each do |id|
        # On stocke plusieurs fois le même texte, ce qui ne sert à rien
        connect_option(object, id, text)
      end
    end
  end

  def connect_option(object, id, text)
    return if id.blank?
    value = values_for(object).where(option_id: id).first_or_create
    value.text = text
    value.save
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
