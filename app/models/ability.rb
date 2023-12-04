# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    send(@user.role.to_sym)
  end

  def visitor
  end

  def admin
    can :manage, :all
    cannot :manage, User, role: :superadmin
  end

  def superadmin
    can :manage, :all
  end
end
