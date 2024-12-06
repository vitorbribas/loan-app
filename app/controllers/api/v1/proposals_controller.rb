# frozen_string_literal: true

class Api::V1::ProposalsController < ApplicationController
  def create
    @proposal = Proposal.new(proposal_params)
    id = Rails.cache.fetch(@proposal.cache_key)

    if id.present?
      @proposal = Proposal.find_by(id: id)
      return render :create, status: :ok
    end

    if @proposal.save
      render :create, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:amount, :payment_term, :birthdate, :email)
  end
end
