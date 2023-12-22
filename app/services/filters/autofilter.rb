module Filters
  class Autofilter
    attr_reader :scope, :parameters

    # parameters = { published: true }
    def initialize(scope, parameters)
      @scope = scope
      @parameters = parameters
    end

    def filter
      return scope if parameters.nil?
      parameters.each do |parameter|
        filter_with(parameter)
      end
      scope
    end

    protected

    def filter_with(parameter)
      (key, value) = parameter
      return unless value_set?(value)
      scope_name = "autofilter_#{key}"
      return unless scope_exists?(scope_name)
      @scope = scope.public_send(scope_name, value)
    end

    def value_set?(value)
      value.is_a?(Array) ? value.reject(&:blank?).any? : value.present?
    end

    def scope_exists?(scope_name)
      scope.respond_to?(scope_name)
    end
  end
end