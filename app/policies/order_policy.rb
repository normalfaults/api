class OrderPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    admin_or_related
  end

  def show?
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

  def items?
    admin_or_related
  end

  private

  def admin_or_related
    user.admin? || user.project_ids.include?(record.project_id)
  end
end
