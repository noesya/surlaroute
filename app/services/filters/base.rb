module Filters
  class Base
    attr_accessor :list

    def initialize(user)
      @user = user
      @list = []
    end

    protected

    def add(scope_name, choices, **options)
      value_method = options[:value_method] || default_value_method
      @list << {
        scope_name: scope_name,
        choices: choices,
        label: options[:label],
        multiple: options[:multiple] || false,
        tree: options[:tree] || false,
        value_method: value_method
      }
    end

    def add_if(condition, args)
      add *args if condition
    end

    def add_search
      add :for_search_term, nil, label: I18n.t('admin.filters.search')
    end

    private

    def default_value_method
      -> (filter, params) { params[filter[:scope_name]] }
    end
  end
end
