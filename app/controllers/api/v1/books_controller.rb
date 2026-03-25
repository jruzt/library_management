module Api
  module V1
    class BooksController < BaseController
      before_action :set_book, only: %i[show update destroy]

      def index
        authorize Book

        books = Book.search(params[:q]).order(:title)

        render json: json_response(resource: books,
                                   serializer: BookSerializer,
                                   meta: {
                                     total: books.size,
                                     query: params[:q].presence
                                   })
      end

      def show
        authorize @book

        render json: json_response(resource: @book,
                                   serializer: BookSerializer)
      end

      def create
        book = Book.new(book_params)
        authorize book
        book.save!

        render json: json_response(resource: book,
                                   serializer: BookSerializer),
               status: :created
      end

      def update
        authorize @book
        @book.update!(book_params)

        render json: json_response(resource: @book,
                                   serializer: BookSerializer)
      end

      def destroy
        authorize @book
        @book.destroy!

        head :no_content
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
      end
    end
  end
end
