# == Schema Information
#
# Table name: banners
#
#  id               :uuid             not null, primary key
#  background_color :string
#  published        :boolean          default(FALSE)
#  text             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Banner < ApplicationRecord
  BACKGROUND_COLOR_OPTIONS = {
    'Vert' => '#beffc1',
    'Violet écosystème' => '#f4d4ff',
    'Jaune projet' => '#f5ff85',
    'Bleu matériaux' => '#b7e0ff',
    'Orange technique' => '#ff8355'
  }
end
