class ToursController < ApplicationController
  include ResourceWithStructure

  def index
    base_scope = @region.present? ? @region.tours : Tour.all
    @all_tours = base_scope.published
    @facets = Tour::Facets.new(
      params[:facets],
      model: @all_tours,
      region: @region
    )
    @tours = @facets.results.ordered_by_creation_date.page(params[:page])
    breadcrumb
  end

  def show
    @tour = Tour.find_by!(slug: params[:id])
    @new_comment = User::Comment.new(about: @tour) if can?(:create, User::Comment)
    breadcrumb
    add_breadcrumb @tour
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Tour.model_name.human(count: 2), tours_path
  end

end
