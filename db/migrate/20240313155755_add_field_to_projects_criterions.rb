class AddFieldToProjectsCriterions < ActiveRecord::Migration[7.1]
  def change
    add_column :project_criterions, :if_you_check, :text
  end
end
