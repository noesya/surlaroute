class CreateUserComments < ActiveRecord::Migration[7.1]
  def change
    create_table :user_comments, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :about, polymorphic: true, null: false, type: :uuid
      t.references :reply_to, foreign_key: {to_table: :user_comments}, type: :uuid
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
