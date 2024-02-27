class Project::Facets < FacetedSearch::FacetsWithItems
  def initialize(params)
    super
    @model = Project.published.ordered
    @class_name = 'Project'
    filter_with_text :name, {
      title: 'Nom'
    }
    add_facets_for_items
  end
end
