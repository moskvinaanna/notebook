# frozen_string_literal: true

# contracthelper module
module ContractHelper
  def validate_contract(contract_class, params)
    symboled_params = params.map { |key, value| [key.to_sym, value] }.to_h
    contract_instance = contract_class.new
    contract_instance.call(**symboled_params)
  end
end
