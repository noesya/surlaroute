class AddPositionToProjectCriterion < ActiveRecord::Migration[7.1]
  def change
    add_column :project_criterions, :position, :integer, default: 1
  end
end
