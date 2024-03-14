class Technic::Facets < FacetedSearch::FacetsWithItems
  def initialize(params)
    super
    @model = Technic.published.ordered
    @class_name = 'Technic'
    filter_with_text :name, {
      title: Technic.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facets_for_items
  end
end
