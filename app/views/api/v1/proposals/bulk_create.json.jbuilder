# frozen_string_literal: true

json.data do
  json.array! @proposals do |proposal|
    json.extract! proposal,
      :amount,
      :payment_term,
      :email
  end
end
