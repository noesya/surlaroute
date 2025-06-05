class RemoveHelloAssoTables < ActiveRecord::Migration[7.2]
  def change
    drop_table :helloasso_tokens
    drop_table :helloasso_events
  end
end
