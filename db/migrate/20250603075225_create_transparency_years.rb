class CreateTransparencyYears < ActiveRecord::Migration[7.2]
  def change
    create_table :transparency_years, id: :uuid do |t|
      t.integer :value

      t.timestamps
    end
  end
end
