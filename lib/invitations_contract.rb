# frozen_string_literal: true

require 'dry-validation'
# checks input of invites' data
class InvitationsContract < Dry::Validation::Contract
  params do
    required(:event).filled(:string)
    required(:event_date).value(:date_time)
    required(:address).filled(:string)
  end
end
