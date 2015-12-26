class AbilityAdmin
  include CanCan::Ability

  def initialize(admin)
    can :manage, :all

    # Article
    cannot :create, Article
    cannot :update, Article

    # ArticleImage
    cannot :create, ArticleImage
    cannot :destroy, ArticleImage
  end
end
