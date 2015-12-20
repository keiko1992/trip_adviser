class Ability
  include CanCan::Ability

  def initialize(user)
    # initialize
    cannot :create, :all
    cannot :read, :all
    cannot :update, :all
    cannot :destroy, :all
  end
end