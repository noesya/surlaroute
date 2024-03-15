# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    send(@user.role.to_sym)
  end

  def visitor
    can :manage, Actor, published_by_id: @user.id
    cannot [:publish, :premium], Actor
    can :manage, Project, published_by_id: @user.id
    cannot :publish, Project
  end
  
  def subscriber
    visitor
    can :read, Actor
    can :read, Project
    can :manage, Material, published_by_id: @user.id
    can :read, Material
    cannot :publish, Material
    can :manage, Technic, published_by_id: @user.id
    can :read, Technic
    cannot :publish, Technic
    can :manage, User::Comment, user_id: @user.id
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
