class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :active, -> { where(returned_at: nil) }
  scope :returned, -> { where.not(returned_at: nil) }
  scope :overdue, -> { active.where("due_on < ?", Time.zone.today) }
  scope :due_today, -> { active.where(due_on: Time.zone.today) }

  validates :borrowed_at, :due_on, presence: true
  validate :returned_at_after_borrowed_at

  def active?
    returned_at.nil?
  end

  def overdue?
    active? && due_on < Time.zone.today
  end

  private

  def returned_at_after_borrowed_at
    return if returned_at.blank? || borrowed_at.blank?
    return if returned_at >= borrowed_at

    errors.add(:returned_at, "must be after the borrowed date")
  end
end
