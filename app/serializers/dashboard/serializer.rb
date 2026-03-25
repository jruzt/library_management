class Dashboard
  class Serializer < BaseSerializer
    set_type :dashboard

    attributes :role, :totals, :overdue_count

    has_many :overdue_members, serializer: Dashboard::OverdueMemberSerializer
    has_many :borrowings, serializer: Dashboard::MemberBorrowingSerializer
  end
end
