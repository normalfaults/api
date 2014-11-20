class SettingPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin?
  end

  def show?
    admin_or_related
  end

  def new?
    # TODO: Can anyone create a new setting?
    true
  end

  def update?
    admin_or_related
  end

  def destroy?
    admin_or_related
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def admin_or_related
    user.admin?
  end
end
