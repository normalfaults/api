class StaffPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    admin_or_self
  end

  def create?
    user.admin?
  end

  def update?
    admin_or_self
  end

  def destroy?
    user.admin?
  end

  def projects?
    admin_or_self
  end

  def add_project?
    user.admin?
  end

  def remove_project?
    user.admin?
  end

  def user_settings?
    admin_or_self
  end

  def show_user_setting?
    admin_or_self
  end

  def create_user_setting?
    admin_or_self
  end

  def update_user_setting?
    admin_or_self
  end

  def destroy_user_setting?
    admin_or_self
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def admin_or_self
    user.admin? || (record.present? && user.id == record.id)
  end
end
