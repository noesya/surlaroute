class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      Material,
      Actor,
      Project,
      Region,
      User,
    ]
    breadcrumb
  end
end
