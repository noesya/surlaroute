# == Schema Information
#
# Table name: transparency_costs
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
#  index_transparency_costs_on_transparency_year_id  (transparency_year_id)
#
# Foreign Keys
#
#  fk_rails_e2e8119787  (transparency_year_id => transparency_years.id)
#
class Transparency::Cost < ApplicationRecord
  belongs_to  :year, 
              class_name: 'Transparency::Year',
              foreign_key: :transparency_year_id

  validates_presence_of :title, :amount

  def to_s
    "#{title}"
  end
end
