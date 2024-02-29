class TechnicsController < ApplicationController
  include ResourceWithStructure

  def index
    @technics = Technic.published.ordered.page(params[:page])
    breadcrumb
  end

  def show
    @technic = Technic.find_by!(slug: params[:id])
    breadcrumb
    add_breadcrumb @technic
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Technic.model_name.human(count: 2), technics_path
  end
end
