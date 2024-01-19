# == Schema Information
#
# Table name: actors
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_id   :uuid             indexed
#
# Indexes
#
#  index_actors_on_region_id  (region_id)
#
# Foreign Keys
#
#  fk_rails_a8de6705d8  (region_id => regions.id)
#
require "test_helper"

class ActorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
