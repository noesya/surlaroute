module Filters
  class Base
    attr_accessor :list

    def initialize(user)
      @user = user
      @list = []
    end

    protected

    def add(scope_name, **options)
      value_method = options[:value_method] || default_value_method
      type = options[:type] || :string
      list_elmt = {
        scope_name: scope_name,
        type: type,
        label: options[:label] || scope_name.humanize,
        value_method: value_method,
        class: options[:class] || '',
        margin_bottom: options[:margin_bottom] || 3
      }
      if [:select, :check_boxes, :radio_buttons, :grouped_select].include?(type)
        list_elmt.merge!({
          collection: options[:collection],
          multiple: options[:multiple] || false
        })
      end
      @list << list_elmt
    end

    def add_if(condition, args)
      add *args if condition
    end

    def add_search
      add :search, label: I18n.t('admin.filters.search_field')
    end

    private

    def default_value_method
      -> (filter, params) { params.require(:filters)[filter[:scope_name]] if params.has_key?(:filters) }
    end
  end
end