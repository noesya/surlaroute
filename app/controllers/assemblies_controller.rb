class AssembliesController < ApplicationController
  include ResourceWithStructure

  def index
    @assemblies = Assembly.all.ordered.page(params[:page])
    breadcrumb
  end

  def show
    @assembly = Assembly.find_by!(slug: params[:id])
    breadcrumb
    add_breadcrumb @assembly
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Assembly.model_name.human(count: 2), assemblies_path
  end
end
