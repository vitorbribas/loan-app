# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'loan-app@example.com'
  layout 'mailer'
end
