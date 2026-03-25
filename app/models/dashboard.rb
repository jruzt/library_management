class Dashboard
  attr_reader :id, :role, :totals, :overdue_members, :borrowings, :overdue_count

  def initialize(id:, role:, totals: nil, overdue_members: [], borrowings: [], overdue_count: nil)
    @id = id
    @role = role
    @totals = totals
    @overdue_members = overdue_members
    @borrowings = borrowings
    @overdue_count = overdue_count
  end

  def overdue_member_ids
    overdue_members.map(&:id)
  end

  def borrowing_ids
    borrowings.map(&:id)
  end
end
