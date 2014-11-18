class ProjectPolicy < ApplicationPolicy
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
    # TODO: Can anyone create a new project
    true
  end

  def update?
    admin_or_related
  end

  def destroy?
    admin_or_related
  end

  def staff?
    admin_or_related
  end

  def add_staff?
    user.admin?
  end

  def remove_staff?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def admin_or_related
    user.admin? || user.project_ids.include?(record.id)
  end
end
