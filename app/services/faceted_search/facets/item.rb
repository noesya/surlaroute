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
      item.options.in_use
    end

    def find_by
      :slug
    end

    def add_scope(scope)
      return scope if params_array.blank?
      # TODO limiter à ceux qui résultats
      alias_suffix = "_#{item.id.gsub('-', '_')}"
      model = facets.class_name.safe_constantize
      options_table_alias = model.connection.quote_column_name("structure_options#{alias_suffix}")
      scope.joins(model.structure_join_chain(alias_suffix)).where(options_table_alias => { id: structure_options_selected })
    end

    def structure_options_selected
      params_array.map { |slug| Structure::Option.find_by(slug: slug) }
    end
  end
end