class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :manage, Food
      can :manage, Recipe
      can :manage, User
    else
      can :read, Food
      can :manage, Food, user_id: user.id
      can :read, Recipe
      can :manage, Recipe, user_id: user.id
    end
  end
end
