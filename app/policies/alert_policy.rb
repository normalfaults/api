class AlertPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin?
  end

  def sensu?
    admin_or_system
  end

  def show?
    admin_or_related
  end

  def show_all?
    admin_or_system
  end

  def show_active?
    admin_or_system
  end

  def show_inactive?
    admin_or_system
  end

  def new?
    admin_or_system
  end

  def update?
    admin_or_system
  end

  def destroy?
    admin_or_system
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def admin_or_related
    user.admin? || record.staff_id == user.id
  end

  def admin_or_system
    user.admin? || system_generated
  end

  def system_generated
    false # TODO: BUILD OUT SYSTEM GENERATED ALERTS LOGIC
  end

end
