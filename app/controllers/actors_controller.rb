class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @mode = params[:mode] || 'list'
    @facets = Actor::Facets.new params[:facets]
    @actors = @facets.results.ordered
    @actors = @actors.page(params[:page]).per(6) if @mode == "list"

    breadcrumb
  end

  def show
    @actor = Actor.find_by!(slug: params[:id])
    @new_comment = User::Comment.new(about: @actor) if current_user
    breadcrumb
    add_breadcrumb @actor
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('ecosystem'), actors_path
  end

end
