# frozen_string_literal: true

require 'dry-validation'
# checks input of new data
class NotesContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    optional(:birthday_date).value(:date)
    required(:status).filled(:string)
    required(:gender).filled(:string)
    optional(:surname).value(:string)
    optional(:cell_phone_num).value(:string)
    optional(:patronymic_name).value(:string)
    optional(:home_phone_num).value(:string)
    optional(:address).value(:string)
  end

  rule(:name) do
    key.failure('Имя должно иметь длину не больше 100 символов') if value.length > 100
  end

  rule(:surname) do
    key.failure('Фамилия должна иметь длину не больше 100 символов') if value.length > 100
  end

  rule(:surname) do
    key.failure('Фамилия должна иметь длину не больше 100 символов') if value.length > 100
  end

  rule(:patronymic_name) do
    key.failure('Отчество должно иметь длину не больше 100 символов') if value.length > 100
  end

  rule(:cell_phone_num) do
    key.failure('Номер мобильного телефона должен иметь длину не больше 20 символов') if value.length > 20
  end

  rule(:home_phone_num) do
    key.failure('Номер домашнего телефона должен иметь длину не больше 15 символов') if value.length > 15
  end

  rule(:address) do
    key.failure('Адрес должен иметь длину не больше 200 символов') if value.length > 200
  end

  rule(:cell_phone_num) do
    unless value.match(/^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/) || value.empty?
      key.failure('Номер телефона может содержать символы + - ( ), а также цифры')
    end
  end

  rule(:home_phone_num) do
    unless value.match(/[\d\- ]{6,10}$/) || value.empty?
      key.failure('Номер телефона может содержать символы + - ( ), а также цифры')
    end
  end

  rule(:status) do
    key.failure('Статус должен иметь длину не больше 100 символов') if value.length > 100
  end

  rule(:gender) do
    key.failure('Имя должно иметь длину не больше 255 символов') if value.length > 255
  end
end
