# == Schema Information
#
# Table name: page_blocks
#
#  id                        :uuid             not null, primary key
#  data                      :jsonb
#  kind                      :integer          default("text")
#  name                      :string
#  position                  :integer          default(1)
#  searchable_text_from_data :text
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  page_id                   :uuid             not null, indexed
#
# Indexes
#
#  index_page_blocks_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_611934c7ce  (page_id => pages.id)
#
class Page::Block < ApplicationRecord
  include Positionable

  enum kind: {
    text: 1,
    quote: 2,
    keypoints: 3,
    gallery: 4,
    collapse: 5,
    files: 6
  }, _prefix: :kind

  belongs_to :page

  after_commit :denormalize_searchable_text_from_data, on: [:create, :update]

  def data=(value)
    data_hash = value.is_a?(Hash) ? value
                                  : JSON.parse(value)
    write_attribute :data, data_hash
  end

  def data
    attributes['data'].present? ? super
                                : { elements: [] }
  end

  def to_s
    name.present? ? "#{name}"
                  : "Bloc"
  end

  protected

  def set_initial_position
    self.position = page.blocks.count + 1
  end

  def denormalize_searchable_text_from_data
    update_column :searchable_text_from_data,
                  CustomSanitizer.sanitize(to_search, 'string')
  end

  def to_search
    # micmac avec factos
    send("to_search_for_#{kind}")
  end

  def to_search_for_text
    texts_from_data_to_search(data, keys: ['text'])
  end

  def to_search_for_quote
    texts_from_data_to_search(data, keys: ['text', 'author'])
  end

  def to_search_for_keypoints
    texts_from_elements_to_search(data['elements'], keys: ['title', 'text'])
  end

  def to_search_for_gallery
    texts_from_elements_to_search(data['elements'], keys: ['caption'])
  end

  def to_search_for_collapse
    texts_from_elements_to_search(data['elements'], keys: ['title', 'text'])
  end

  def to_search_for_files
    texts_from_elements_to_search(data['elements'], keys: ['title', 'text']) do |texts, element|
      texts << texts_from_elements_to_search(element['fields'], keys: ['title'])
    end
  end

  def texts_from_data_to_search(data, keys: [])
    texts = []
    keys.each do |key|
      texts << data.dig(key)
    end
    texts.compact_blank.join(' ')
  end

  def texts_from_elements_to_search(elements, keys: [], &block)
    elements ||= []
    texts = []
    elements.each do |element|
      texts << texts_from_data_to_search(element, keys: keys)
      block.call(texts, element) if block.present?
    end
    texts.compact_blank.join(' ')
  end
end
