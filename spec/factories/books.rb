FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    author { "Octavia Butler" }
    genre { "Science Fiction" }
    sequence(:isbn) { |n| "ISBN-#{n}" }
    total_copies { 3 }
  end
end
