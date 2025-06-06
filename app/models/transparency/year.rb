# == Schema Information
#
# Table name: transparency_years
#
#  id         :uuid             not null, primary key
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Transparency::Year < ApplicationRecord
  has_many :costs, foreign_key: :transparency_year_id
  has_many :revenues, foreign_key: :transparency_year_id

  validates :value,
            presence: true,
            uniqueness: true

  scope :ordered, -> { order(value: :desc) }

  def total_costs
    @total_costs ||= costs.sum(:amount)
  end

  def total_revenues
    @total_revenues ||= revenues.sum(:amount)
  end

  def total
    @total ||= total_revenues - total_costs
  end

  def to_s
    "#{value}"
  end
end
