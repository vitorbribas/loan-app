# frozen_string_literal: true

json.data do
  json.extract! @proposal,
    :loan_total_payment,
    :loan_monthly_payment,
    :loan_total_interest
end
