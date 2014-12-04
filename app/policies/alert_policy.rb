class AlertPolicy < ApplicationPolicy
  def index?
    admin_or_related
  end

  def create?
    admin_or_related
  end

  def show?
    admin_or_related
  end

  def show_all?
    admin_or_related
  end

  def show_active?
    admin_or_related
  end

  def show_inactive?
    admin_or_related
  end

  def new?
    admin_or_related
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
    user.admin? || system_generated
  end

  def system_generated
    false # TODO: BUILD OUT SYSTEM GENERATED ALERTS LOGIC
  end
end
