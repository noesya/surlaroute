# == Schema Information
#
# Table name: regions
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  slug        :string           indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_regions_on_slug  (slug) UNIQUE
#
require "test_helper"

class RegionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
