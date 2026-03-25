class Dashboard
  class MemberBorrowingSerializer < BaseSerializer
    set_type :borrowing

    attributes :due_on

    attribute :overdue do |object|
      object.overdue?
    end

    belongs_to :book, serializer: Dashboard::MemberBookSerializer
  end
end
