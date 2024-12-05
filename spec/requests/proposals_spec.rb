# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Proposals' do
  let(:valid_attributes) do
    {
      amount: 1000.0,
      payment_term: 12,
      birthdate: '01/01/1990'
    }
  end
  let(:invalid_attributes) do
    {
      amount: 0,
      payment_term: 0,
      birthdate: ''
    }
  end
  let(:json) { response.parsed_body.deep_symbolize_keys }

  describe 'POST /create' do
    context 'with valid attributes' do
      let(:proposal) { Proposal.last }

      it 'creates a new Proposal' do
        expect do
          post api_v1_proposals_path, params: { proposal: valid_attributes }
        end.to change(Proposal, :count).by(1)
      end

      it 'returns a successful response', :aggregate_failures do
        post api_v1_proposals_path, params: { proposal: valid_attributes }

        expect(response).to be_successful
        expect(json[:data][:loan_total_payment]).to eq(proposal.loan_total_payment)
        expect(json[:data][:loan_monthly_payment]).to eq(proposal.loan_monthly_payment)
        expect(json[:data][:loan_total_interest]).to eq(proposal.loan_total_interest)
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
end
