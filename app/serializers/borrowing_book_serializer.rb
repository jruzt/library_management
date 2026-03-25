class BorrowingBookSerializer < BaseSerializer
  set_type :book

  attributes :title, :author, :genre, :isbn
end
