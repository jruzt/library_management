module Borrowings
  class ReturnBook
    def initialize(borrowing:)
      @borrowing = borrowing
    end

    def call
      raise ActiveRecord::RecordInvalid.new(error_record("Book has already been returned")) unless borrowing.active?

      borrowing.update!(returned_at: Time.zone.now)
      borrowing
    end

    private

    attr_reader :borrowing

    def error_record(message)
      Borrowing.new.tap do |record|
        record.errors.add(:base, message)
      end
    end
  end
end
