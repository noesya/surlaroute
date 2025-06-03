# == Schema Information
#
# Table name: transparency_revenues
#
#  id                   :uuid             not null, primary key
#  amount               :integer
#  description          :text
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  transparency_year_id :uuid             not null, indexed
#
# Indexes
#
#  index_transparency_revenues_on_transparency_year_id  (transparency_year_id)
#
# Foreign Keys
#
#  fk_rails_aedc53e0e2  (transparency_year_id => transparency_years.id)
#
class Transparency::Revenue < ApplicationRecord
  belongs_to  :year, 
              class_name: 'Transparency::Year',
              foreign_key: :transparency_year_id

  validates_presence_of :title, :amount

  def to_s
    "#{title}"
  end
end
