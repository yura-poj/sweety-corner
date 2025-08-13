class CategoryPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def destroy?
    admin?
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if admin?
  #   relation.where(user: user)
  # end
end
