# == Schema Information
#
# Table name: materials
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string           indexed
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  actor_id        :uuid             indexed
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_materials_on_actor_id         (actor_id)
#  index_materials_on_published_by_id  (published_by_id)
#  index_materials_on_slug             (slug)
#
# Foreign Keys
#
#  fk_rails_d5f504ce55  (published_by_id => users.id)
#  fk_rails_e6f2c9950b  (actor_id => actors.id)
#
require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
