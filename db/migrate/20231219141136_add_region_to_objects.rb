class AddRegionToObjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :region, type: :uuid
    add_reference :materials, :region, type: :uuid
  end
end
