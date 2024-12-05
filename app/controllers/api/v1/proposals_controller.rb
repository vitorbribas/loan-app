# frozen_string_literal: true

# frozen_string_literal

class Api::V1::ProposalsController < ApplicationController
  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      render :create, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:amount, :payment_term, :birthdate)
  end
end
