# frozen_string_literal: true

require 'rails_helper'
require 'age_calculator'

RSpec.describe AgeCalculator do
  describe '#call' do
    subject(:calculator) { described_class.new(birthdate) }

    let(:supposed_age) { today.year - birthdate.year }
    let(:today) { Time.zone.today }
    let(:factor) { Faker::Number.between(from: 18, to: 50) }

    context 'when birthday has not passed' do
      let(:birthdate) { (today + 1.day) - factor.years }

      it 'returns the correct age' do
        expect(calculator.call).to eq(supposed_age - 1)
      end
    end

    context 'when birthday has passed' do
      let(:birthdate) { (today - 1.day) - factor.years }

      it 'returns the correct age' do
        expect(calculator.call).to eq(supposed_age)
      end
    end

    context 'when birthday is today' do
      let(:birthdate) { today - factor.years }

      it 'returns the correct age' do
        expect(calculator.call).to eq(supposed_age)
      end
    end
  end
end
