class RegionsController < ApplicationController

  def index
    @regions = Region.all.ordered.page(params[:page])
    breadcrumb
    add_breadcrumb Region.model_name.human(count: 2), regions_path(region_slug: nil)
  end

  def show
    @region = Region.find_by!(slug: params[:id])
    @materials = @region.materials
    @projects = @region.projects
    breadcrumb
  end

end
