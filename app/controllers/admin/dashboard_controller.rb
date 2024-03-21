class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      Actor,
      Project,
      Material,
      Technic,
      Page,
      Definition,
      Region,
      User,
    ]
    @comments_pending = User::Comment.pending.count
    breadcrumb
  end
end
