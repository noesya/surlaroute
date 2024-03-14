class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @mode = params[:mode] || 'list'
    facets_model = @region.present? ? @region.actors : Actor.all
    @facets = Actor::Facets.new(params[:facets], model: facets_model)
    @actors = @facets.results.ordered
    @actors = @actors.page(params[:page]).per(6) if @mode == "list"

    breadcrumb
  end

  def show
    @actor = Actor.find_by!(slug: params[:id])
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
