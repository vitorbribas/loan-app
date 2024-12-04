# frozen_string_literal: true

class Proposal < ApplicationRecord
  validates :amount, :person_age, :payment_term, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :person_age, numericality: { greater_than: 18 }
  validates :payment_term, numericality: { greater_than: 0 }
end
