# frozen_string_literal: true

class ProposalsMailer < ApplicationMailer
  def deliver_simulation(proposal)
    @proposal = proposal

    mail(to: @proposal.email,
      subject: I18n.t('mailers.proposals.deliver_simulation.subject'))
  end
end
