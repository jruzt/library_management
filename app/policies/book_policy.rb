class BookPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user&.librarian?
  end

  def update?
    user&.librarian?
  end

  def destroy?
    user&.librarian?
  end
end
