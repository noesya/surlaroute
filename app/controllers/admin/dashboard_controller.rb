class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      Actor,
      Project,
      Material,
      Technic,
      Tour,
      Page,
      Definition,
      Region,
      User,
      Subscription
    ]
    @comments_pending_count = User::Comment.pending.count
    breadcrumb
  end
end
