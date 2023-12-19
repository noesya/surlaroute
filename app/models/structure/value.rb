# == Schema Information
#
# Table name: criterion_values
#
#  id           :uuid             not null, primary key
#  about_type   :string           not null, indexed => [about_id]
#  text         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  about_id     :uuid             not null, indexed => [about_type]
#  criterion_id :uuid             not null, indexed
#
# Indexes
#
#  index_criterion_values_on_about         (about_type,about_id)
#  index_criterion_values_on_criterion_id  (criterion_id)
#
# Foreign Keys
#
#  fk_rails_8490687e7c  (criterion_id => criterions.id)
#
class Structure::Value < ApplicationRecord
  belongs_to :about, polymorphic: true
  belongs_to :item
end
