module Filters
  class Admin::Users < Filters::Base
    def initialize(user)
      super
      add_search
      add_for_role
    end

    private

    def add_for_role
      add :for_role,
          ::User.roles.keys.map { |r| { to_s: I18n.t("activerecord.attributes.user.roles.#{r}"), id: r } },
          label: 'Filtrer par rôle'
    end

  end
end
