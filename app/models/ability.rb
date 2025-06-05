# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    send(@user.role.to_sym)
  end

  def visitor
    can :manage, Actor, id: @user.actor_ids
    cannot [:publish, :premium, :lab_member], Actor
    can :create, Actor
    can :manage, Project, id: @user.project_ids
    cannot :publish, Project
    can :create, Project
    can :manage, Material, id: @user.material_ids
    cannot :publish, Material
    can :create, Material
    can :manage, Technic, id: @user.technic_ids
    cannot :publish, Technic
    can :create, Technic
  end
  
  def subscriber
    visitor
    can :read, Actor
    can :read, Project
    can [:read, :create], Material
    can [:read, :create], Technic
    # can :manage, User::Comment, user_id: @user.id
    can :create, User::Comment
    can :manage, User::Favorite, user_id: @user.id
  end

  def lab_member
    subscriber
  end

  def admin
    can :manage, :all
    cannot :manage, User, role: :superadmin
    can :read, User, role: :superadmin
    cannot :manage, Structure::Item
    cannot :manage, Product
    cannot :manage, Region
  end

  def superadmin
    can :manage, :all
  end
end
