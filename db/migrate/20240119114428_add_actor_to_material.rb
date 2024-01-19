class AddActorToMaterial < ActiveRecord::Migration[7.1]
  def change
    add_reference :materials, :actor, foreign_key: true, type: :uuid
  end
end
