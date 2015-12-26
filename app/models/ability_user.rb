class AbilityUser
  include CanCan::Ability

  def initialize(user)
    # Article
    can :create, Article
    can :read, Article
    can :list, Article
    can :search, Article
    can :update, Article
    can :destroy, Article

    # ArticleImage
    can :create, ArticleImage
    can :destroy, ArticleImage
  end
end
