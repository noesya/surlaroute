class Technic::Facets < FacetedSearch::FacetsWithItems
  def initialize(params)
    super
    @model = Technic.published.ordered
    @class_name = 'Technic'
    filter_with_text :name, {
      title: 'Nom'
    }
    add_facets_for_items
  end
end
