class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :read, :all
      can :create, Review
      can :destroy, Review, :user_id => user.id
    else
      can :read, :all
    end
  end
end
