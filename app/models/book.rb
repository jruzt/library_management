class Book < ApplicationRecord
  has_many :borrowings, dependent: :restrict_with_exception

  validates :title, :author, :genre, :isbn, presence: true
  validates :isbn, uniqueness: true
  validates :total_copies, numericality: { only_integer: true, greater_than: 0 }

  scope :search, lambda { |query|
    return all if query.blank?

    pattern = "%#{sanitize_sql_like(query.strip)}%"
    where("title ILIKE :pattern OR author ILIKE :pattern OR genre ILIKE :pattern", pattern:)
  }

  def active_borrowings_count
    borrowings.active.count
  end

  def available_copies
    total_copies - active_borrowings_count
  end

  def available?
    available_copies.positive?
  end
end
