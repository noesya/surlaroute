class Material::Facets < FacetedSearch::FacetsWithItems
  def initialize(params)
    super
    @model = Material.published.ordered
    @class_name = 'Material'
    filter_with_text :name, {
      title: 'Nom'
    }
    add_facets_for_items
  end
end
