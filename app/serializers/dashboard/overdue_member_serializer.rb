class Dashboard
  class OverdueMemberSerializer < BaseSerializer
    set_type :user

    attributes :full_name, :email

    attribute :overdue_books_count do |object|
      object.borrowings.overdue.count
    end
  end
end
