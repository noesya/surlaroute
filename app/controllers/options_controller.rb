class OptionsController < ApplicationController
  before_action :load_about, :load_item

  def show
    @option = @item.options.find_by(slug: params[:option_slug])
    @objects = @option.objects
    @objects = @objects.where(region: @region) if @region.present?
    breadcrumb
    add_breadcrumb @option
    render 'structure/options/show'
  end
  
  protected
  
  def load_about
    # 'materiaux'
    @resources_slug_i18n = params[:resources_slug]
    # La clé `routes` est une convention de la gem `route_translator`
    # {:materials=>"materiaux", :projects=>"projets"}
    # -> {"materiaux"=>:materials, "projets"=>:projects}
    slug_to_class = t('routes').invert
    # 'materials'
    @resources_slug = slug_to_class[@resources_slug_i18n].to_s
    # 'Material'
    @resources_class_string = @resources_slug.singularize.titleize
    # Material
    @resources_class = @resources_class_string.constantize
  end

  def load_item
    @item = Structure::Item.find_by(slug: params[:item_slug], about_class: @resources_class_string)
  end

  def breadcrumb
    super
    add_breadcrumb @resources_class.model_name.human(count: 2), @resources_class
  end
end