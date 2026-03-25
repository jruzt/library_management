FactoryBot.define do
  factory :borrowing do
    association :user
    association :book
    borrowed_at { Time.zone.now }
    due_on { 2.weeks.from_now.to_date }
    returned_at { nil }

    trait :returned do
      returned_at { Time.zone.now }
    end

    trait :overdue do
      borrowed_at { 3.weeks.ago }
      due_on { 1.week.ago.to_date }
    end
  end
end
