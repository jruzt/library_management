class BorrowingSerializer < BaseSerializer
  set_type :borrowing

  attributes :borrowed_at, :due_on

  attribute :active do |object|
    object.active?
  end

  attribute :overdue do |object|
    object.overdue?
  end

  attribute :returned_at do |object|
    object.returned_at&.strftime("%Y-%m-%d %H:%M")
  end

  belongs_to :user, serializer: BorrowingUserSerializer
  belongs_to :book, serializer: BorrowingBookSerializer
end
