class AbilityUser
  include CanCan::Ability

  def initialize(user)
    # Article
    can :create, Article
    can :read, Article
    can :list, Article
    can :update, Article
    can :destroy, Article
  end
end
