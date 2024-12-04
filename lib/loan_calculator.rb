# frozen_string_literal: true

require 'bigdecimal'

class LoanCalculator
  MONTHS_IN_YEAR = 12

  def initialize(amount, annual_rate, payment_term)
    @amount = BigDecimal(amount.to_s)
    @annual_rate = BigDecimal(annual_rate.to_s)
    @payment_term = BigDecimal(payment_term.to_s)
    validate_args
  end

  def call
    monthly_payment
  end

  private

  def monthly_payment
    (numerator / denominator).round(2).to_f
  end

  def numerator
    @amount * monthly_rate
  end

  def denominator
    BigDecimal(1) - ((BigDecimal(1) + monthly_rate)**-@payment_term)
  end

  def monthly_rate
    @annual_rate / BigDecimal(MONTHS_IN_YEAR)
  end

  def validate_args
    raise ArgumentError, 'Amount must be greater than zero' if @amount <= 0
    raise ArgumentError, 'Annual rate must be greater than zero' if @annual_rate <= 0
    raise ArgumentError, 'Payment term must be greater than zero' if @payment_term <= 0
  end
end
