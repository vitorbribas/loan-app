# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proposal do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:person_age) }
    it { is_expected.to validate_presence_of(:payment_term) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:person_age).is_greater_than(18) }
    it { is_expected.to validate_numericality_of(:payment_term).is_greater_than(0) }
  end
end
