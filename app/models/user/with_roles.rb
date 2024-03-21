module User::WithRoles
  extend ActiveSupport::Concern

  included do
    delegate :can?, :cannot?, to: :ability

    attr_accessor :modified_by

    enum role: { visitor: 0, subscriber: 5, lab_member: 10, admin: 20, superadmin: 30 }

    before_validation :set_default_role, on: :create
    before_validation :check_modifier_role

    scope :for_role, -> (role) { where(role: role) }
    # "Or" condition in incoming scope is because someone might have been set as author when subscriber, and is now only a visitor. 
    # We don't want to lose the actual author even if he's not subscriber anymore
    scope :possible_authors, -> (author_ids) { not_visitor.or(where(id: author_ids)) }

    def managed_roles
      User.roles.map do |role_name, role_id|
        next if role_id > User.roles[role]
        role_name
      end.compact
    end

    def ability
      @ability ||= Ability.new(self)
    end

    def possible_author?
      # mirror of the "possible_authors" scope
      !visitor
    end

    protected

    def check_modifier_role
      errors.add(:role, 'ne peut pas être modifié pour ce rôle') if modified_by && !modified_by.managed_roles.include?(self.role)
    end

    def set_default_role
      return if superadmin?
      if User.all.empty?
        self.role = :superadmin
      elsif User.not_superadmin.empty?
        self.role = :admin
      end
    end

  end
end
