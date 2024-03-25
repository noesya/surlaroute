class CreateHelloassoTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :helloasso_tokens, id: :uuid do |t|
      t.text :access_token
      t.text :refresh_token

      t.timestamps
    end
  end
end
