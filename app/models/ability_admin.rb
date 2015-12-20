class AbilityAdmin
  include CanCan::Ability

  def initialize(admin)
    can :manage, :all
  end
end
