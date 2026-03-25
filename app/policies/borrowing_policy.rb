class BorrowingPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user&.member?
  end

  def return_book?
    user&.librarian?
  end
end
