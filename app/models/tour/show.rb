# == Schema Information
#
# Table name: tour_shows
#
#  id         :uuid             not null, primary key
#  day        :date
#  published  :boolean          default(FALSE)
#  status     :integer          default("draft")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :uuid             not null, indexed
#  tour_id    :uuid             not null, indexed
#
# Indexes
#
#  index_tour_shows_on_place_id  (place_id)
#  index_tour_shows_on_tour_id   (tour_id)
#
# Foreign Keys
#
#  fk_rails_a58e53755d  (tour_id => tours.id)
#  fk_rails_dccff436e9  (place_id => actors.id)
#
class Tour::Show < ApplicationRecord
  include Commentable
  include Favoritable
  include Loggable
  include Orderable
  include Publishable
  include Regional
  include Structured

  has_and_belongs_to_many :authors,
                          class_name: 'User',
                          join_table: 'tour_shows_users',
                          association_foreign_key: :user_id
  belongs_to :tour
  belongs_to :place, class_name: 'Actor'

  scope :ordered, -> { order(:day) }
  scope :ordered_reverse, -> { order(day: :desc) }

  validates_presence_of :day, :place

  def to_s
    title.present? ? "#{title}" : "#{I18n.l(day)}, #{place}"
  end
end
