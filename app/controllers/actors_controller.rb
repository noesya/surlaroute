class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @facets = Actor::Facets.new params[:facets]
    @actors = @facets.results.ordered.page params[:page]
    breadcrumb
  end

  def show
    @actor = Actor.find_by!(slug: params[:id])
    breadcrumb
    add_breadcrumb @actor
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ecosystem'), actors_path
  end
end
