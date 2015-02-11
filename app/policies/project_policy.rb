class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
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

  def approvals?
    true
  end

  def approve?
    user.admin?
  end

  def reject?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope
      else
        # Users are only allowed to see projects they've created or have been added to
        scope.joins(:staff_projects).where(staff_projects: { staff_id: user.id })
      end
    end
  end

  private

  def admin_or_related
    user.admin? || user.project_ids.include?(record.id)
  end
end
