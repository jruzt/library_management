class BorrowingSerializer < BaseSerializer
  set_type :borrowing

  attributes :borrowed_at, :due_on, :returned_at

  attribute :active do |object|
    object.active?
  end

  attribute :overdue do |object|
    object.overdue?
  end

  belongs_to :user, serializer: BorrowingUserSerializer
  belongs_to :book, serializer: BorrowingBookSerializer
end
