# frozen_string_literal: true

require 'annual_rate_mapper'
require 'rails_helper'

RSpec.describe AnnualRateMapper do
  describe '#call' do
    subject(:mapper) { described_class.new(age) }

    context 'when age is within supported range' do
      context 'when age is within 18-25' do
        let(:age) { Faker::Number.between(from: 18, to: 25) }
        let(:rate) { 0.05 }

        it 'returns the correct rate' do
          expect(mapper.call).to eq(rate)
        end
      end

      context 'when age is within 26-40' do
        let(:age) { Faker::Number.between(from: 26, to: 40) }
        let(:rate) { 0.03 }

        it 'returns the correct rate' do
          expect(mapper.call).to eq(rate)
        end
      end

      context 'when age is within 41-60' do
        let(:age) { Faker::Number.between(from: 41, to: 60) }
        let(:rate) { 0.02 }

        it 'returns the correct rate' do
          expect(mapper.call).to eq(rate)
        end
      end

      context 'when age is within 61-100' do
        let(:age) { Faker::Number.between(from: 61, to: 100) }
        let(:rate) { 0.04 }

        it 'returns the correct rate' do
          expect(mapper.call).to eq(rate)
        end
      end
    end

    context 'when age is outside of supported range' do
      let(:error_message) { "Invalid age: #{age}. Supported age range is 18 to 100." }

      context 'when age is bellow 18' do
        let(:age) { Faker::Number.between(from: 1, to: 17) }

        it 'raises an InvalidAge error' do
          expect { mapper.call }.to raise_error(described_class::InvalidAge, error_message)
        end
      end

      context 'when age is above 100' do
        let(:age) { Faker::Number.between(from: 101, to: 110) }

        it 'raises an InvalidAge error' do
          expect { mapper.call }.to raise_error(described_class::InvalidAge, error_message)
        end
      end
    end
  end
end
