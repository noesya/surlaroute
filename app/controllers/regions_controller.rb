class RegionsController < ApplicationController

  def index
    @regions = Region.all.ordered.page(params[:page])
    breadcrumb
  end

  def show
    @region = Region.find_by!(slug: params[:slug])
    @materials = @region.materials
    @projects = @region.projects
    breadcrumb
    add_breadcrumb @region
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Region.model_name.human(count: 2), regions_path
  end

end
