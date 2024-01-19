class ActorsController < ApplicationController
  include ResourceWithStructure

  def index
    @actors = Actor.all.ordered.page(params[:page])
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
    add_breadcrumb Actor.model_name.human(count: 2), actors_path
  end
end
