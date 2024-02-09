# == Schema Information
#
# Table name: actors
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_actors_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_666a0f2abc  (published_by_id => users.id)
#
require "test_helper"

class ActorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
