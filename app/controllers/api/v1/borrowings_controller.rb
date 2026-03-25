module Api
  module V1
    class BorrowingsController < BaseController
      before_action :set_borrowing, only: :return_book

      def index
        authorize Borrowing

        borrowings = if current_user.librarian?
          Borrowing.includes(:user, :book).order(created_at: :desc)
        else
          current_user.borrowings.includes(:book).order(created_at: :desc)
        end

        render json: json_response(resource: borrowings,
                                   serializer: BorrowingSerializer,
                                   include: %i[user book],
                                   meta: {
                                     total: borrowings.size
                                   })
      end

      def create
        authorize Borrowing

        book = Book.find(params.require(:book_id))
        borrowing = Borrowings::Create.new(user: current_user, book: book).call

        render json: json_response(resource: borrowing,
                                   serializer: BorrowingSerializer,
                                   include: %i[user book]), status: :created
      end

      def return_book
        authorize @borrowing, :return_book?

        borrowing = Borrowings::ReturnBook.new(borrowing: @borrowing).call
        render json: json_response(resource: borrowing,
                                   serializer: BorrowingSerializer,
                                   include: %i[user book])
      end

      private

      def set_borrowing
        @borrowing = Borrowing.includes(:user, :book).find(params[:id])
      end
    end
  end
end
