class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin? || user.supplier?
      can :manage, :all
#		elsif user.supplier?
#			can [:read, :update], Supplier, id: user.supplier_admin.supplier.id
#			can :manage, [Item, Category, Order], id: user.supplier_admin.supplier.id
#
    else
      can :read, User, id: user.id
      can :read, Order
    end
  end
end
