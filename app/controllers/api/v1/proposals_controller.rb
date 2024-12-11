# frozen_string_literal: true

class Api::V1::ProposalsController < ApplicationController
  def create
    @proposal = Proposal.new(proposal_params)
    id = Rails.cache.fetch(@proposal.cache_key)

    @proposal = Proposal.find_by(id: id) if id.present?

    if @proposal.save
      @proposal.deliver_simulation
      render :create, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def bulk_create
    @proposals = bulk_create_params[:proposals].map do |bulk_create_params|
      @proposal = Proposal.new(bulk_create_params)
      id = Rails.cache.fetch(@proposal.cache_key)

      if id.present?
        @proposal = Proposal.find_by(id: id)
      else
        @proposal.save!
      end
      @proposal.enqueue_simulation
      @proposal
    end

    render :bulk_create, status: :created
  rescue NoMethodError => e
    @errors = e.message
    render :bulk_errors, status: :unprocessable_entity
  end

  private

  def proposal_params
    params.require(:proposal).permit(:amount, :payment_term, :birthdate, :email)
  end

  def bulk_create_params
    params.permit(proposals: %i[amount payment_term birthdate email])
  end
end
