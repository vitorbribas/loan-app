# frozen_string_literal: true

class AgeCalculator
  def initialize(birthdate)
    @birthdate = birthdate.to_date
  end

  def call
    age = now.year - @birthdate.year
    birthday_passed? ? age : age - 1
  end

  private

  def now
    @now ||= Time.zone.today
  end

  def birthday_passed?
    now.month > @birthdate.month ||
      (now.month == @birthdate.month && now.day >= @birthdate.day)
  end
end
