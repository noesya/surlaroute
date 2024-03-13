class CreateProjectAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :project_answers, id: :uuid do |t|
      t.references :criterion, null: false, foreign_key: {to_table: :project_criterions}, type: :uuid
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.boolean :value
      t.text :text

      t.timestamps
    end
  end
end
