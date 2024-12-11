# frozen_string_literal: true

json.data do
  json.extract! @proposal,
    :total_payment,
    :monthly_payment,
    :total_interest
end
