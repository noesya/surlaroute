class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      User,
      Material
    ]
    breadcrumb
  end
end
