class Admin::AnalyticsController < Admin::ApplicationController
  def index
    breadcrumb
    add_breadcrumb t('admin.analytics')
  end
end
