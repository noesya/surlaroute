class Material::Facets < FacetedSearch::FacetsWithItems
  def initialize(params)
    super
    @model = Material.published.ordered
    @class_name = 'Material'
    filter_with_text :name, {
      title: Material.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facets_for_items
  end
end
