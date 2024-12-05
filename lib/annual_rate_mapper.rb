# frozen_string_literal: true

class AnnualRateMapper
  class InvalidAge < StandardError; end

  SUPPORTED_MIN_AGE = Integer(ENV.fetch('SUPPORTED_MIN_AGE', 18))
  SUPPORTED_MAX_AGE = Integer(ENV.fetch('SUPPORTED_MAX_AGE', 100))

  AGE_RANGES = [
    { range: 18..25, rate: 0.05 },
    { range: 26..40, rate: 0.03 },
    { range: 41..60, rate: 0.02 },
    { range: 61..100, rate: 0.04 }
  ].freeze

  def initialize(client_age)
    @client_age = client_age
    validate_args
  end

  def call
    find_rate
  end

  private

  def find_rate
    age_range = AGE_RANGES.find { |range| range[:range].include?(@client_age) }
    age_range[:rate] if age_range
  end

  def validate_args
    return if @client_age >= SUPPORTED_MIN_AGE && @client_age <= SUPPORTED_MAX_AGE

    raise InvalidAge,
      "Invalid age: #{@client_age}. Supported age range is " /
        "#{SUPPORTED_MIN_AGE} to #{SUPPORTED_MAX_AGE}."
  end
end
