# == Schema Information
#
# Table name: project_criterions
#
#  id           :uuid             not null, primary key
#  hint         :text
#  if_you_check :text
#  name         :string
#  position     :integer          default(1)
#  step         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Project::Criterion < ApplicationRecord
  
  STEPS = (0..7)
  
  include Positionable

  has_many :answers

  scope :for_step, -> (step) { where(step: step).ordered }

  def to_s
    "#{name}"
  end
end
