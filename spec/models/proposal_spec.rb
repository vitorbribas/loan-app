# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proposal do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:tax_factor) }
    it { is_expected.to validate_presence_of(:payment_term) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:tax_factor).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:payment_term).is_greater_than(0) }
  end
end
