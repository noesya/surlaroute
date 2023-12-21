module ResourceWithStructure
  extend ActiveSupport::Concern

  def option
    # materials
    @resources_slug = params[:controller]
    # Material
    @resources_class_string = @resources_slug.singularize.titleize
    # 
    @item = Structure::Item.find_by(slug: params[:item_slug], about_class: @resources_class_string)
    @option = @item.options.find_by(slug: params[:option_slug])
    @objects = @option.objects
    @objects = @objects.where(region: @region) if @region.present?
    breadcrumb
    add_breadcrumb @option
    render 'structure/options/show'
  end
end