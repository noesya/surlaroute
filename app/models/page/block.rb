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
                  CustomSanitizer.sanitize(raw_searchable_text_from_data, 'string')
  end

  def raw_searchable_text_from_data
    ActionController::Base.render(
      partial: "admin/pages/blocks/kinds/#{kind}/searchable",
      locals: { data: data }
    )
  end
end
