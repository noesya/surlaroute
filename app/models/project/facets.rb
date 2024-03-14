class Project::Facets < FacetedSearch::FacetsWithItems
  def initialize(params, **options)
    super(params)
    @model = options[:model].published
    @class_name = 'Project'
    add_facets_for_order
    filter_with_text :name, {
      title: Project.human_attribute_name('name'),
      placeholder: I18n.t('search.search_in_name')
    }
    add_facets_for_items
  end
end
