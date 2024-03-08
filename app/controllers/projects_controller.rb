class ProjectsController < ApplicationController
  include ResourceWithStructure

  def index
    @facets = Project::Facets.new params[:facets]
    @projects = @facets.results.ordered.page params[:page]
    breadcrumb
  end

  def show
    @project = Project.find_by!(slug: params[:id])
    @new_comment = User::Comment.new(about: @project) if current_user
    breadcrumb
    add_breadcrumb @project
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Project.model_name.human(count: 2), projects_path
  end

end
