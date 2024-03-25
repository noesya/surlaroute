class CreateHelloassoEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :helloasso_events, id: :uuid do |t|
      t.jsonb :data

      t.timestamps
    end
  end
end
