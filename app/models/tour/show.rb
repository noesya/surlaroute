# == Schema Information
#
# Table name: tour_shows
#
#  id         :uuid             not null, primary key
#  published  :boolean          default(FALSE)
#  status     :integer          default(0)
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
  belongs_to :tour
  belongs_to :place
end
