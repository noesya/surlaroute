class AddPremiumToActors < ActiveRecord::Migration[7.1]
  def change
    add_column :actors, :premium, :boolean, default: false
  end
end
