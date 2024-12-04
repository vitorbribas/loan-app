# frozen_string_literal: true

FactoryBot.define do
  factory :proposal do
    amount { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    person_age { Faker::Number.between(from: 18, to: 70) }
    payment_term { [12, 24, 36].sample }
  end
end
