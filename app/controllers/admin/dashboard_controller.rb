class Admin::DashboardController < Admin::ApplicationController
  def index
    @metrics = [
      User
    ]
    breadcrumb
  end
end
