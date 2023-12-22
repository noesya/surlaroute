module Filters
  class Admin::Users < Filters::Base

    def initialize(user)
      super
      add_search
      add_role
    end

    private

    def add_role
      add :role,
          type: :select,
          collection: ::User.roles.keys.map { |r| { to_s: I18n.t("activerecord.attributes.user.roles.#{r}"), id: r } },
          label: ::User.human_attribute_name(:role)
    end

  end
end