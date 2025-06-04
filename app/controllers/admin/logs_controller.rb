class Admin::LogsController < Admin::ApplicationController
  load_and_authorize_resource class: 'User::Log'

  include Admin::FiltersHelper

  def index
    @logs = @logs.ordered.page(params[:page])
    breadcrumb
    add_breadcrumb User::Log.model_name.human(count: 2)
  end

end