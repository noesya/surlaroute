class MaterialsController < ApplicationController
  include ResourceWithStructure

  def index
    facets_model = @region.present? ? @region.materials : Material.all
    @facets = Material::Facets.new(params[:facets], model: facets_model)
    @materials = @facets.results.ordered.page(params[:page]).per(6)
    breadcrumb
  end

  def show
    @material = Material.find_by!(slug: params[:id])
    @new_comment = User::Comment.new(about: @material) if can?(:create, User::Comment)
    breadcrumb
    add_breadcrumb @material
  end

  protected

  def breadcrumb
    super
    add_breadcrumb Material.model_name.human(count: 2), materials_path
  end
end
