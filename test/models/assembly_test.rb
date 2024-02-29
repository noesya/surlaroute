# == Schema Information
#
# Table name: assemblies
#
#  id              :uuid             not null, primary key
#  description     :text
#  image_alt       :string
#  image_credit    :string
#  name            :string
#  published       :boolean          default(FALSE)
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_by_id :uuid             indexed
#
# Indexes
#
#  index_assemblies_on_published_by_id  (published_by_id)
#
# Foreign Keys
#
#  fk_rails_402a0ffef2  (published_by_id => users.id)
#
require "test_helper"

class AssemblyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
