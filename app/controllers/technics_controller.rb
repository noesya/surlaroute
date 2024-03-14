class TechnicsController < ApplicationController
  include ResourceWithStructure

  def index
    facets_model = @region.present? ? @region.technics : Technic.all
    @facets = Technic::Facets.new(params[:facets], model: facets_model)
    @technics = @facets.results.ordered.page(params[:page]).per(24)
    breadcrumb
  end

  def show
    @technic = Technic.find_by!(slug: params[:id])
    @new_comment = User::Comment.new(about: @technic) if can?(:create, User::Comment)
    breadcrumb
    add_breadcrumb @technic
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Technic.model_name.human(count: 2), technics_path
  end
end
