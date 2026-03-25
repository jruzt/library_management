class BookSerializer < BaseSerializer
  set_type :book

  attributes :title,
             :author,
             :genre,
             :isbn,
             :total_copies,
             :available_copies,
             :active_borrowings_count
end
