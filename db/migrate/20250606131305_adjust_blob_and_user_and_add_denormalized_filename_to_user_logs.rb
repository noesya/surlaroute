class AdjustBlobAndUserAndAddDenormalizedFilenameToUserLogs < ActiveRecord::Migration[7.2]
  def change
    change_column_null :user_logs, :blob_id, true
    change_column_null :user_logs, :user_id, true
    add_column :user_logs, :filename, :string
  end
end
