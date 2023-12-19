# == Schema Information
#
# Table name: materials
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string           indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_id   :uuid             indexed
#
# Indexes
#
#  index_materials_on_region_id  (region_id)
#  index_materials_on_slug       (slug)
#
require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
