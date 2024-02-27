class Actor::Facets < FacetedSearch::Facets
  def initialize(params)
    super

    @model = Actor.published.ordered

    filter_with_text :name

    items.each do |item|
      add_facet ::FacetedSearch::Facets::Item, item.slug, { item: item }
    end
  end

  def items
    @items ||= Structure::Item.where(about_class: 'Actor').with_options.ordered
  end
end
