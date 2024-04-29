module ResourceWithStructure
  extend ActiveSupport::Concern

  def options
    @items = Structure::Item.where(about_class: resources_class_string).with_options.ordered
    breadcrumb
    add_breadcrumb t('glossary.title'), request.path
    render 'structure/options/index'
  end

  def option
    @item = Structure::Item.find_by!(slug: params[:item_slug], about_class: resources_class_string)
    @option = @item.options.find_by!(slug: params[:option_slug])
    @objects = @option.objects.published.ordered
    @objects = @objects.joins(:regions).where(regions: { id: @region.id }) if @region.present?
    breadcrumb
    add_breadcrumb t('glossary.title'), public_send("options_#{ resources_class_string.downcase.pluralize}_path")
    add_breadcrumb @option
    render 'structure/options/show'
  end

  protected

  def breadcrumb
    super
    t('glossary.title')
  end

  # materials
  def resources_slug
    @resources_slug ||= params[:controller]
  end

  # Material
  def resources_class_string
    @resources_class_string ||= resources_slug.singularize.titleize
  end
end
