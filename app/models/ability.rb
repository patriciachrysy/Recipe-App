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
      can :create, Food
      can :update, Food, user_id: user.id
      can :destroy, Food, user_id: user.id

      can :read, Recipe
      can :create, Recipe
      can :update, Recipe, user_id: user.id
      can :destroy, Recipe, user_id: user.id
    end
  end
end
