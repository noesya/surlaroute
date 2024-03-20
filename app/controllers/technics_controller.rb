class TechnicsController < ApplicationController
  include ResourceWithStructure

  def index
    base_scope = @region.present? ? @region.technics : Technic.all
    @all_technics = base_scope.published
    @facets = Technic::Facets.new(params[:facets], model: @all_technics)
    @technics = @facets.results.ordered_by_creation_date.page(params[:page])
    breadcrumb
  end

  def show
    @technic = Technic.find_by!(slug: params[:id])
    @actors = @technic.actors.published.ordered
    @projects = @technic.projects.published.ordered
    @new_comment = User::Comment.new(about: @technic) if can?(:create, User::Comment)
    breadcrumb
    add_breadcrumb @technic
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Technic.model_name.human(count: 2), technics_path
  end
end
