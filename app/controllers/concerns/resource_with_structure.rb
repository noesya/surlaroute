module ResourceWithStructure
  extend ActiveSupport::Concern

  def options
    @items = Structure::Item.where(about_class: resources_class_string).with_options.ordered
    breadcrumb
    add_breadcrumb 'Glossaire', request.path
    render 'structure/options/index'
  end

  def option
    @item = Structure::Item.find_by(slug: params[:item_slug], about_class: resources_class_string)
    @option = @item.options.find_by(slug: params[:option_slug])
    @objects = @option.objects
    @objects = @objects.where(region: @region) if @region.present?
    breadcrumb
    add_breadcrumb @option
    render 'structure/options/show'
  end

  protected

  # materials
  def resources_slug
    @resources_slug ||= params[:controller]
  end

  # Material
  def resources_class_string
    @resources_class_string ||= resources_slug.singularize.titleize
  end
end