class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
    elsif user.customer?
      can :read, :all
      can :manage, :review, user_id: user.id
      can :update, :order, user_id: user.id
    else
      can :read, :all
    end
  end
end
