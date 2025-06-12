class Tour::Facets < FacetedSearch::FacetsWithItems
  def initialize(params, **options)
    super(params)
    @model = options[:model].published
    @region = options[:region]
    @class_name = 'Tour'
    add_facets_for_order
    filter_with_text :name, {
      title: Tour.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facet FacetedSearch::Facets::Year, :year, {
      title: Tour.human_attribute_name('year')
    }
    add_facets_for_items
    add_facets_for_regions unless @region.present?
  end
end
