# == Schema Information
#
# Table name: projects
#
#  id              :uuid             not null, primary key
#  description     :text
#  image_alt       :string
#  image_credit    :string
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string           indexed
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_projects_on_published_by_id  (published_by_id)
#  index_projects_on_slug             (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_fef370b0dc  (published_by_id => users.id)
#
require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
