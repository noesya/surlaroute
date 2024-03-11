# == Schema Information
#
# Table name: page_blocks
#
#  id         :uuid             not null, primary key
#  data       :jsonb
#  kind       :integer          default("text")
#  name       :string
#  position   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  page_id    :uuid             not null, indexed
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
  belongs_to :page

  scope :ordered, -> { order(:position) }

  enum kind: {
    text: 1,
    quote: 2
  }, _prefix: :kind

  def to_s
    "#{name}"
  end
end
