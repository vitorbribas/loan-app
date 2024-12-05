# frozen_string_literal: true

class Proposal < ApplicationRecord
  attr_accessor :birthdate

  validates :amount, :person_age, :payment_term, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :person_age, numericality: { greater_than: 18 }
  validates :payment_term, numericality: { greater_than: 0 }

  before_validation :store_person_age

  delegate :total_payment, :monthly_payment, :total_interest,
    to: :loan_calculator, prefix: :loan

  private

  def store_person_age
    return if person_age.present?

    return errors.add(:birthdate, 'is required') if birthdate.blank?

    self.person_age = AgeCalculator.new(birthdate).call
  end

  def loan_calculator
    @loan_calculator ||= LoanCalculator.new(amount, annual_rate, payment_term)
  end

  def annual_rate
    @annual_rate ||= AnnualRateMapper.new(person_age).call
  end
end
