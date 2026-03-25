module Borrowings
  class Create
    def initialize(user:, book:)
      @user = user
      @book = book
    end

    def call
      raise ActiveRecord::RecordInvalid.new(user) unless user.member?

      book.with_lock do
        validate_availability!
        validate_not_already_borrowed!

        Borrowing.create!(
          user: @user,
          book: @book,
          borrowed_at: Time.zone.now,
          due_on: 2.weeks.from_now.to_date
        )
      end
    end

    private

    attr_reader :user, :book

    def validate_availability!
      return if book.available?

      raise ActiveRecord::RecordInvalid.new(build_error_record("Book is not available right now"))
    end

    def validate_not_already_borrowed!
      return unless user.borrowings.active.exists?(book_id: book.id)

      raise ActiveRecord::RecordInvalid.new(build_error_record("You already have this book borrowed"))
    end

    def build_error_record(message)
      Borrowing.new.tap do |borrowing|
        borrowing.errors.add(:base, message)
      end
    end
  end
end
