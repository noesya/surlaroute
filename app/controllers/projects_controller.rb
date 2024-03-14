class ProjectsController < ApplicationController
  include ResourceWithStructure

  def index
    facets_model = @region.present? ? @region.projects : Project.all
    @facets = Project::Facets.new(params[:facets], model: facets_model)
    @projects = @facets.results.ordered.page(params[:page]).per(6)
    breadcrumb
  end

  def show
    @project = Project.find_by!(slug: params[:id])
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
