# frozen_string_literal: true

class Producer::ProposalSimulation
  def initialize(proposal)
    @proposal = proposal
  end

  def call
    Rails.logger.info("######## Proposal sent to SQS queue: #{@proposal.id} ########")
  end
end
