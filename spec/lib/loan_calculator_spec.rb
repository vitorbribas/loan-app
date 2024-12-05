# frozen_string_literal: true

require 'rails_helper'
require 'loan_calculator'

RSpec.describe LoanCalculator do
  subject(:calculator) { described_class.new(amount, annual_rate, payment_term) }

  let(:annual_rate) { 0.05 }

  shared_examples 'raises ArgumentError' do
    it 'raises an error' do
      expect { calculator }.to raise_error(ArgumentError, error_message)
    end
  end

  shared_examples 'calculates the correct monthly payment' do |expected_payment|
    it 'calculates the correct monthly payment' do
      expect(calculator.monthly_payment).to eq(expected_payment)
    end
  end

  shared_examples 'calculates the correct total payment' do |expected_payment|
    it 'calculates the correct total payment' do
      expect(calculator.total_payment).to eq(expected_payment)
    end
  end

  shared_examples 'calculates the correct total interest' do |expected_payment|
    it 'calculates the correct total interest' do
      expect(calculator.total_interest).to eq(expected_payment)
    end
  end

  describe '#initialize' do
    context 'with invalid inputs' do
      let(:amount) { 1000 }
      let(:payment_term) { 12 }

      context 'when amount is zero' do
        let(:amount) { 0 }
        let(:error_message) { 'Amount must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end

      context 'when annual rate is zero' do
        let(:annual_rate) { 0 }
        let(:error_message) { 'Annual rate must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end

      context 'when payment term is zero' do
        let(:payment_term) { 0 }
        let(:error_message) { 'Payment term must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end

      context 'when amount is negative' do
        let(:amount) { -1000 }
        let(:error_message) { 'Amount must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end

      context 'when annual rate is negative' do
        let(:annual_rate) { -0.05 }
        let(:error_message) { 'Annual rate must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end

      context 'when payment term is negative' do
        let(:payment_term) { -12 }
        let(:error_message) { 'Payment term must be greater than zero' }

        it_behaves_like 'raises ArgumentError'
      end
    end
  end

  describe '#monthly_payment' do
    context 'with valid inputs' do
      context 'for a 1-year loan' do
        let(:amount) { 1000 }
        let(:payment_term) { 12 }

        it_behaves_like 'calculates the correct monthly payment', 85.61
      end

      context 'for a 5-year loan' do
        let(:amount) { 10_000 }
        let(:payment_term) { 60 }

        it_behaves_like 'calculates the correct monthly payment', 188.71
      end

      context 'for a 10-year loan' do
        let(:amount) { 50_000 }
        let(:payment_term) { 120 }

        it_behaves_like 'calculates the correct monthly payment', 530.33
      end
    end
  end

  describe '#total_payment' do
    context 'with valid inputs' do
      context 'for a 1-year loan' do
        let(:amount) { 1000 }
        let(:payment_term) { 12 }

        it_behaves_like 'calculates the correct total payment', 1027.32
      end

      context 'for a 5-year loan' do
        let(:amount) { 10_000 }
        let(:payment_term) { 60 }

        it_behaves_like 'calculates the correct total payment', 11_322.60
      end

      context 'for a 10-year loan' do
        let(:amount) { 50_000 }
        let(:payment_term) { 120 }

        it_behaves_like 'calculates the correct total payment', 63_639.60
      end
    end
  end

  describe '#total_interest' do
    context 'with valid inputs' do
      context 'for a 1-year loan' do
        let(:amount) { 1000 }
        let(:payment_term) { 12 }

        it_behaves_like 'calculates the correct total interest', 27.32
      end

      context 'for a 5-year loan' do
        let(:amount) { 10_000 }
        let(:payment_term) { 60 }

        it_behaves_like 'calculates the correct total interest', 1322.60
      end

      context 'for a 10-year loan' do
        let(:amount) { 50_000 }
        let(:payment_term) { 120 }

        it_behaves_like 'calculates the correct total interest', 13_639.60
      end
    end
  end
end
