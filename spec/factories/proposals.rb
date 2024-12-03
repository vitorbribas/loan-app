# frozen_string_literal: true

FactoryBot.define do
  factory :proposal do
    amount { Faker::Number.between(from: 1000, to: 5000) }
    tax_factor { Faker::Number.between(from: 2, to: 5) }
    payment_term { [12, 24, 36].sample }
  end
end
