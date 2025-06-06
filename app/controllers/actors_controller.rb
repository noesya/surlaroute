class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @mode = params[:mode] || 'list'
    base_scope = @region.present? ? @region.actors : Actor.all
    @all_actors = base_scope.published
    @facets = Actor::Facets.new(
      params[:facets],
      model: @all_actors,
      region: @region
    )
    @actors = @facets.results.ordered_by_creation_date
    @actors = @actors.page(params[:page]) if @mode == "list"

    breadcrumb
  end

  def show
    @actor = Actor.find_by!(slug: params[:id])
    @materials = @actor.materials.published.ordered
    @projects = @actor.projects.published.ordered
    @technics = @actor.technics.published.ordered
    @new_comment = User::Comment.new(about: @actor) if can?(:create, User::Comment)

    breadcrumb
    add_breadcrumb @actor
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ecosystem'), actors_path
  end

end
