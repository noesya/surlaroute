class CreateJoinTableProjectsUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :projects, :users, column_options: {type: :uuid} do |t|
      t.index [:project_id, :user_id]
    end

    Project.where.not(published_by_id: nil).each do |project|
      project.authors << project.published_by
    end

  end
end
