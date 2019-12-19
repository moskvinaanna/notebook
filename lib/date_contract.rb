# frozen_string_literal: true

require 'dry-validation'
# checks date input
class DateContract < Dry::Validation::Contract
  params do
    optional(:date).value(:date)
  end
end
