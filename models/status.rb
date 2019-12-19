# frozen_string_literal: true

require 'sequel'
# model for a statuses datatable
class Status < Sequel::Model(:statuses)
  one_to_many :notes

  def self.add_new_note(person)
    find_or_create(name: person[:status])
      .add_note(name: person[:name],
                surname: person[:surname],
                patronymic_name: person[:patronymic_name],
                cell_phone_num: person[:cell_phone_num],
                home_phone_num: person[:home_phone_num],
                address: person[:address],
                birthday_date: person[:birthday_date],
                gender: person[:gender])
  end

  def self.is_empty?(status_id)
    self[status_id].notes.empty?
  end
end
