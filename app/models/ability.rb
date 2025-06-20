# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    send(@user.role.to_sym)
  end

  def visitor
    # Actor
    can :manage, Actor, id: @user.actor_ids
    cannot [:publish, :premium, :update_sources], Actor
    can :create, Actor
    # Project
    can :manage, Project, id: @user.project_ids
    cannot [:publish, :update_sources], Project
    can :create, Project
    # Material
    can :manage, Material, id: @user.material_ids
    cannot [:publish, :update_sources], Material
    can :create, Material
    # Technic
    can :manage, Technic, id: @user.technic_ids
    cannot [:publish, :update_sources], Technic
    can :create, Technic
    # Tour
    can :manage, Tour, id: @user.tour_ids
    cannot [:publish, :update_sources], Tour
    can :create, Tour
    # Tour::Show
    can :manage, Tour::Show, id: @user.tour_show_ids
    cannot [:publish, :update_sources], Tour::Show
    can :create, Tour::Show
  end

  def lab_member
    visitor
    can [:read, :update_sources], Actor
    can [:read, :update_sources], Project
    can [:read, :update_sources], Material
    can [:read, :update_sources], Technic
    can [:read, :update_sources], Tour
    can [:read, :update_sources], Tour::Show
    # can :manage, User::Comment, user_id: @user.id
    can :create, User::Comment
    can :manage, User::Favorite, user_id: @user.id
  end

  def admin
    can :manage, :all
    cannot :manage, User, role: :superadmin
    can :read, User, role: :superadmin
    cannot :manage, Structure::Item
    cannot :manage, Region
  end

  def superadmin
    can :manage, :all
  end
end
