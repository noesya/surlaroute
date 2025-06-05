class SwitchSubscribers < ActiveRecord::Migration[7.2]
  def up
    User.where(role: 5).update_all(role: :visitor)
  end
end
