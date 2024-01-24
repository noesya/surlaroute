class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      Material,
      Actor,
      Project,
      Assembly,
      Region,
      User,
    ]
    breadcrumb
  end
end
