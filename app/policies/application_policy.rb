# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  authorize :user, optional: true

  def admin?
    user&.admin?
  end

  def auth?
    user.present?
  end
end
