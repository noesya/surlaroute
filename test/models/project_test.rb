# == Schema Information
#
# Table name: projects
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
#  index_projects_on_region_id  (region_id)
#  index_projects_on_slug       (slug) UNIQUE
#
require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
