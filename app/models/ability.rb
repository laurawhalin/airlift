class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
		elsif user.supplier?
			can [:read, :update], Supplier, slug: user.supplier_admin.supplier.slug
			can [:manage], [Item, Category], supplier_id: user.supplier_admin.supplier.id
    else
      can :read, User, id: user.id
      can :read, Cart, id: user.id
    end
  end
end
