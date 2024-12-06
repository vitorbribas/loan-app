# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proposal do
  let(:valid_params) do
    { amount: 1000.0,
      person_age: 34,
      payment_term: 12,
      birthdate: '1990-01-01',
      email: 'test@example.com' }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:person_age) }
    it { is_expected.to validate_presence_of(:payment_term) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:person_age).is_greater_than(18) }
    it { is_expected.to validate_numericality_of(:payment_term).is_greater_than(0) }
  end

  describe '#write_cache' do
    let(:proposal) { described_class.new(valid_params) }

    before { allow(Rails.cache).to receive(:write).and_call_original }

    it 'writes to cache after saving' do
      proposal.save!
      expect(Rails.cache).to have_received(:write).with(proposal.cache_key, proposal.id)
    end
  end

  describe '#cache_key' do
    it 'defines cache key as' do
      proposal = described_class.new(valid_params)
      expect(proposal.cache_key).to eq(
        [valid_params[:email],
         valid_params[:amount],
         valid_params[:payment_term],
         valid_params[:birthdate]]
      )
    end
  end

  describe '#store_person_age' do
    let(:proposal) { described_class.new(valid_params) }

    before { valid_params.delete(:person_age) }

    context 'when birthdate is present' do
      it 'calls AgeCalculator' do
        allow(AgeCalculator).to receive(:new).and_call_original
        proposal.save!
        expect(AgeCalculator).to have_received(:new).with('1990-01-01')
      end

      it 'stores person age' do
        proposal.save!
        expect(proposal.person_age).to eq(34)
      end
    end

    context 'when birthdate is blank' do
      let(:proposal) { described_class.new(valid_params) }

      it 'adds error' do
        proposal.birthdate = ''
        proposal.valid?
        expect(proposal.errors[:birthdate]).to include('is required')
      end
    end
  end
end
