class RemoveLabMemberFromActors < ActiveRecord::Migration[7.2]
  def change
  remove_column :actors, :lab_member
  end
end
