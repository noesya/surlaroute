module FacetedSearch
  class Facets::Item < Facets::DefaultList
    attr_reader :item

    def initialize(name, params, facets, options)
      @name = name
      @params = params
      @facets = facets
      @options = options
      @item = options[:item]
    end

    def title
      item.to_s
    end

    def values
      item.options
    end
    
    def find_by
      :slug
    end

    def add_scope(scope)
      return scope if params_array.blank?
      # TODO limiter aux résultats
      scope.joins(:structure_options).where(structure_options: { id: structure_options_selected })
    end

    def structure_options_selected
      params_array.map { |slug| Structure::Option.find_by(slug: slug) }
    end
  end
end