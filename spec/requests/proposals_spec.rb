# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Proposals' do
  let(:valid_attributes) do
    {
      amount: 1000.0,
      payment_term: 12,
      birthdate: '01/01/1990',
      email: 'email@example.com'
    }
  end
  let(:invalid_attributes) do
    {
      amount: 0,
      payment_term: 0,
      birthdate: '',
      email: ''
    }
  end
  let(:json) { response.parsed_body.deep_symbolize_keys }
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

  describe 'POST /create' do
    context 'with valid attributes' do
      context 'when the Proposal already exists' do
        let(:proposal) { build(:proposal, valid_attributes) }

        before do
          allow(Rails).to receive(:cache).and_return(memory_store)
          Rails.cache.clear
          proposal.save
        end

        it 'does not create a new Proposal' do
          expect do
            post api_v1_proposals_path, params: { proposal: valid_attributes }
          end.not_to change(Proposal, :count)
        end

        it 'returns Proposal id that matches to cache key' do
          post api_v1_proposals_path, params: { proposal: valid_attributes }

          expect(Rails.cache.read(proposal.cache_key)).to eq(proposal.id)
        end

        it 'returns a successful response', :aggregate_failures do
          post api_v1_proposals_path, params: { proposal: valid_attributes }

          expect(response).to have_http_status(:created)
          expect(json[:data][:total_payment]).to eq(proposal.reload.total_payment.to_s)
          expect(json[:data][:monthly_payment]).to eq(proposal.reload.monthly_payment.to_s)
          expect(json[:data][:total_interest]).to eq(proposal.reload.total_interest.to_s)
        end
      end

      context 'when the Proposal does not exist' do
        let(:proposal) { Proposal.last }

        it 'creates a new Proposal' do
          expect do
            post api_v1_proposals_path, params: { proposal: valid_attributes }
          end.to change(Proposal, :count).by(1)
        end

        it 'returns a successful response', :aggregate_failures do
          post api_v1_proposals_path, params: { proposal: valid_attributes }

          expect(response).to have_http_status(:created)
          expect(json[:data][:total_payment]).to eq(proposal.reload.total_payment.to_s)
          expect(json[:data][:monthly_payment]).to eq(proposal.reload.monthly_payment.to_s)
          expect(json[:data][:total_interest]).to eq(proposal.reload.total_interest.to_s)
        end
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new Proposal' do
        expect do
          post api_v1_proposals_path, params: { proposal: invalid_attributes }
        end.not_to change(Proposal, :count)
      end

      it 'returns an unprocessable entity response' do
        post api_v1_proposals_path, params: { proposal: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /bulk_create' do
    context 'with valid parameters' do
      let(:proposals) do
        proposals = []

        1000.times do |_i|
          birth_year = rand(1930..2002)
          birthdate = Date.new(birth_year, rand(1..12), rand(1..28)).strftime('%d/%m/%Y')
          amount = rand(1000.0..10_000.0).round(2)
          payment_term = rand(12..100)

          proposals << {
            amount: amount,
            payment_term: payment_term,
            birthdate: birthdate,
            email: 'bulk-email@example.com'
          }
        end

        proposals
      end

      it 'creates multiple Proposals', :aggregate_failures do
        expect do
          post bulk_create_api_v1_proposals_path, params: { proposals: proposals }
        end.to change(Proposal, :count).by(1000)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create any Proposals', :aggregate_failures do
        proposals_params = Array.new(1000, invalid_attributes)
        expect do
          post bulk_create_api_v1_proposals_path, params: { proposals: proposals_params }
        end.not_to change(Proposal, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
