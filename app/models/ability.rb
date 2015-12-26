class Ability
  include CanCan::Ability

  def initialize(user)
    # initialize
    cannot :create, :all
    cannot :read, :all
    cannot :update, :all
    cannot :destroy, :all

    # Article
    can :read, Article
    can :search, Article
  end
end
