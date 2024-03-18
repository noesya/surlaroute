# == Schema Information
#
# Table name: project_answers
#
#  id           :uuid             not null, primary key
#  text         :text
#  value        :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  criterion_id :uuid             not null, indexed
#  project_id   :uuid             not null, indexed
#
# Indexes
#
#  index_project_answers_on_criterion_id  (criterion_id)
#  index_project_answers_on_project_id    (project_id)
#
# Foreign Keys
#
#  fk_rails_9378bc50b9  (criterion_id => project_criterions.id)
#  fk_rails_eb385c1821  (project_id => projects.id)
#
class Project::Answer < ApplicationRecord
  belongs_to :criterion
  belongs_to :project
end
