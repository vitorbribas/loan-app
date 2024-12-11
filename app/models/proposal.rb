# frozen_string_literal: true

class Proposal < ApplicationRecord
  attr_accessor :birthdate

  validates :amount, :person_age, :payment_term, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :person_age, numericality: { greater_than: 18 }
  validates :payment_term, numericality: { greater_than: 0 }
  validates :monthly_payment, :total_payment, :total_interest,
    numericality: { greater_than: 0 }, allow_nil: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation :store_person_age
  after_save :write_cache

  def cache_key
    [email, amount, payment_term, birthdate]
  end

  def persist_simulation
    if monthly_payment.present? && total_payment.present? && total_interest.present?
      return
    end

    update(
      monthly_payment: loan_calculator.monthly_payment,
      total_payment: loan_calculator.total_payment,
      total_interest: loan_calculator.total_interest
    )
  end

  def enqueue_simulation
    Producer::ProposalSimulation.new(self).call
  end

  def deliver_simulation
    ProposalsMailer.deliver_simulation(self).deliver_now
  end

  private

  def store_person_age
    return if person_age.present?

    return errors.add(:birthdate, 'is required') if birthdate.blank?

    self.person_age = AgeCalculator.new(birthdate).call
  end

  def write_cache
    Rails.cache.write(cache_key, id)
  end

  def loan_calculator
    @loan_calculator ||= LoanCalculator.new(amount, annual_rate, payment_term)
  end

  def annual_rate
    @annual_rate ||= AnnualRateMapper.new(person_age).call
  end
end
