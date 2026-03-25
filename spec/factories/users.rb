FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name { "Alex" }
    last_name { "Reader" }
    password { "password123" }
    password_confirmation { "password123" }
    role { :member }

    trait :librarian do
      role { :librarian }
    end
  end
end
