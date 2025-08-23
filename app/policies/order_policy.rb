class OrderPolicy < ApplicationPolicy
  def index?
    auth?
  end

  def show?
    auth?
  end

  def cart?
    auth?
  end

  def destroy_cart?
    auth?
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  relation_scope do |relation|
    next relation if admin?
    relation.where(user: user)
  end
end
