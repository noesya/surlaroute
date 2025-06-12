module FacetedSearch
  class Facets::Year < Facets::DefaultList

    def source
      @source ||= begin
        results = params_array.compact.blank? ? facets.results : facets.results_except(param_name)
        results.send(:all).where("year IS NOT NULL")
      end
    end

    def add_scope(scope)
      return scope if params_array.compact.blank?
      scope.where(
        "year IN (?)",
        params_array.compact
      )
    end

    def values
      @values ||= source.distinct(:year).order(year: :desc).pluck(:year).uniq.reject(&:blank?)
    end
  end
end