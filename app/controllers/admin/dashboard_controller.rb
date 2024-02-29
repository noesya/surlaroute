class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      Material,
      Actor,
      Project,
      Technic,
      Region,
      User,
    ]
    breadcrumb
  end
end
