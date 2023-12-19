class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      User,
      Project,
      Material,
      Region
    ]
    breadcrumb
  end
end
