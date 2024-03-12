class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @facets = Actor::Facets.new params[:facets]
    @actors = @facets.results.ordered.page(params[:page]).per(6)
    paginate_actors
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

  def paginate_actors
    first_page_count = 6
    items_per_page = 6
    if @actors.first_page?
      @actors = @actors.per(first_page_count)
    else
      @actors = @actors.per(items_per_page).padding(first_page_count - items_per_page)
    end
  end
end
