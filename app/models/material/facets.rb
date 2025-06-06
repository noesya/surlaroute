class Material::Facets < FacetedSearch::FacetsWithItems
  def initialize(params, **options)
    super(params)
    @model = options[:model].published
    @region = options[:region]
    @class_name = 'Material'
    add_facets_for_order
    filter_with_text :name, {
      title: Material.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facets_for_items
    add_facets_for_regions unless @region.present?
  end
end
