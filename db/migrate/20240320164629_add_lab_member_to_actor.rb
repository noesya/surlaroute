class AddLabMemberToActor < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :lab_member, :boolean, default: false
  end
end
