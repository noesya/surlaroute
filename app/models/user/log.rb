# == Schema Information
#
# Table name: user_logs
#
#  id         :uuid             not null, primary key
#  about_type :string           not null, indexed => [about_id]
#  filename   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  about_id   :uuid             not null, indexed => [about_type]
#  blob_id    :uuid             indexed
#  user_id    :uuid             indexed
#
# Indexes
#
#  index_user_logs_on_about    (about_type,about_id)
#  index_user_logs_on_blob_id  (blob_id)
#  index_user_logs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_5e30ac5c4b  (blob_id => active_storage_blobs.id)
#  fk_rails_903088cca6  (user_id => users.id)
#
class User::Log < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :about, polymorphic: true
  belongs_to :blob, class_name: 'ActiveStorage::Blob', optional: true

  before_validation :set_filename, on: :create

  scope :ordered, -> { order(created_at: :desc) }

  protected

  def set_filename
    return unless blob.present?
    self.filename = blob.filename.to_s
  end
end
