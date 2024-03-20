class ProjectsController < ApplicationController
  include ResourceWithStructure

  def index
    base_scope = @region.present? ? @region.projects : Project.all
    @all_projects = base_scope.published
    @facets = Project::Facets.new(params[:facets], model: @all_projects)
    @projects = @facets.results.ordered_by_creation_date.page(params[:page]).per(9)
    breadcrumb
  end

  def show
    @project = Project.find_by!(slug: params[:id])
    @actors = @project.actors.published.ordered
    @materials = @project.materials.published.ordered
    @technics = @project.technics.published.ordered
    @new_comment = User::Comment.new(about: @project) if can?(:create, User::Comment)
    breadcrumb
    add_breadcrumb @project
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Project.model_name.human(count: 2), projects_path
  end

end
