# frozen_string_literal: true

json.errors do
  json.array! @proposal.errors.full_messages
end
