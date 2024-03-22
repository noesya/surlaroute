# == Schema Information
#
# Table name: products
#
#  id           :uuid             not null, primary key
#  description  :text
#  name         :string
#  price        :decimal(, )
#  redirect_url :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Product < ApplicationRecord
  scope :ordered, -> { order(:price) }

  # 5,00€ => 500
  def helloasso_price
    (price * 100).to_i
  end

  def to_s
    "#{name}"
  end
end
