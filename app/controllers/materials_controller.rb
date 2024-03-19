class MaterialsController < ApplicationController
  include ResourceWithStructure

  def index
    base_scope = @region.present? ? @region.materials : Material.all
    @all_materials = base_scope.published
    @facets = Material::Facets.new(params[:facets], model: @all_materials)
    @materials = @facets.results.ordered_by_creation_date.page(params[:page]).per(6)
    breadcrumb
  end

  def show
    @material = Material.find_by!(slug: params[:id])
    @actors = @material.actors.published.ordered
    @projects = @material.projects.published.ordered
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
