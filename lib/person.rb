# frozen_string_literal: true

require 'date'
# describes a person
class Person
  attr_reader :address
  attr_reader :birthday_date
  attr_reader :cell_phone_num
  attr_reader :gender
  attr_reader :home_phone_num
  attr_reader :name
  attr_reader :patronymic_name
  attr_reader :status
  attr_reader :surname
  def initialize(person)
    @name = person[:name]
    @surname = person[:surname]
    @patronymic_name = person[:patronymic_name]
    @cell_phone_num = person[:cell_phone_num]
    @home_phone_num = person[:home_phone_num]
    @address = person[:address]
    @birthday_date = person[:birthday_date]
    @gender = person[:gender]
    @status = person[:status]
  end
end

