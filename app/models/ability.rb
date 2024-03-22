# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    send(@user.role.to_sym)
  end

  def visitor
    can :manage, Actor, id: @user.actor_ids
    cannot [:publish, :premium], Actor
    can :create, Actor
    can :manage, Project, id: @user.project_ids
    cannot :publish, Project
    can :create, Project
  end
  
  def subscriber
    visitor
    can :read, Actor
    can :read, Project
    can :manage, Material, id: @user.material_ids
    can [:read, :create], Material
    cannot :publish, Material
    can :manage, Technic, id: @user.technic_ids
    can [:read, :create], Technic
    cannot :publish, Technic
    can :manage, User::Comment, user_id: @user.id
    can :manage, User::Favorite, user_id: @user.id
  end

  def lab_member
    subscriber
  end

  def admin
    can :manage, :all
    cannot :manage, User, role: :superadmin
  end

  def superadmin
    can :manage, :all
  end
end
