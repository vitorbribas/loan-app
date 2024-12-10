# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProposalsMailer do
  describe '#deliver_simulation' do
    let(:proposal) { create(:proposal) }
    let(:mail) { described_class.deliver_simulation(proposal) }

    it 'renders the mailer headers', :aggregate_failures do
      expect(mail.subject).to eq(I18n.t('mailers.proposals.deliver_simulation.subject'))
      expect(mail.to).to eq([proposal.email])
      expect(mail.from).to eq(['loan-app@example.com'])
    end

    it 'renders the mailer body', :aggregate_failures do
      expect(mail.body.encoded).to match(proposal.amount.to_s)
      expect(mail.body.encoded).to match(proposal.payment_term.to_s)
      expect(mail.body.encoded).to match(proposal.loan_total_payment.to_s)
      expect(mail.body.encoded).to match(proposal.loan_monthly_payment.to_s)
      expect(mail.body.encoded).to match(proposal.loan_total_interest.to_s)
    end
  end
end
