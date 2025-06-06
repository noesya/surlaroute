# == Schema Information
#
# Table name: banners
#
#  id               :uuid             not null, primary key
#  background_color :string
#  published        :boolean
#  text             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Banner < ApplicationRecord


end
