class CreateUserLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :user_logs, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :about, polymorphic: true, null: false, type: :uuid
      t.references :blob, null: false, foreign_key: {to_table: :active_storage_blobs}, type: :uuid

      t.timestamps
    end
  end
end
