class Actor::Facets < FacetedSearch::FacetsWithItems
  def initialize(params, **options)
    super(params)
    @model = options[:model].published
    @class_name = 'Actor'
    filter_with_text :name, {
      title: Actor.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facets_for_items
  end
end
