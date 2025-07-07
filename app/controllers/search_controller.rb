class SearchController < ApplicationController
  def show
    @term = params[:term].to_s.strip
    @actors = Actor.search(@term, where: { published: true }, page: params[:actors_page], per_page: 8)
    @tours = Tour.search(@term, where: { published: true }, page: params[:tours_page], per_page: 8)

    @no_results = [@actors, @tours].all?(&:empty?)
    breadcrumb
  end

  protected

  def breadcrumb
    super
    add_breadcrumb t('search.title')
  end
end
