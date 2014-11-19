class ProjectQuestionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin?
  end

  def show?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
