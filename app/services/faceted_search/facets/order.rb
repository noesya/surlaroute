module FacetedSearch
  class Facets::Order < Facets::DefaultList
    def source
      @options[:source]
    end

    def add_scope(scope)
      return scope if params.blank?
      scope.public_send(name, params)
    end

    def values
      source
    end

    def value_selected?(value)
      params == value
    end

    def path_for(value)
      value_selected?(value) ? path('') : path(value)
    end
  end
end