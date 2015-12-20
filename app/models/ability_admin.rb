class AbilityAdmin
  include CanCan::Ability

  def initialize(admin)
    can :manage, :all

    # Article
    cannot :create, Article
    cannot :update, Article
  end
end
