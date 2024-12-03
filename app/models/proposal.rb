# frozen_string_literal: true

class Proposal < ApplicationRecord
  validates :amount, :tax_factor, :payment_term, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_factor, numericality: { greater_than: 0 }
  validates :payment_term, numericality: { greater_than: 0 }
end
