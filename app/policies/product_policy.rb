class ProductPolicy < ApplicationPolicy
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

  def add_to_cart?
    auth?
  end

  def remove_from_cart?
    auth?
  end

  def destroy_from_cart?
    auth?
  end
end
