# == Schema Information
#
# Table name: products
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  scope :ordered, -> { order(:price) }

  def to_s
    "#{name}"
  end
end
