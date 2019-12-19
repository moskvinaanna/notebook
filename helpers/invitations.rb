# frozen_string_literal: true

require 'date'
# handles invitations
module Invitations
  def self.get_text(event, date, place)
    text = ["Приглашаем Вас на #{event}, которое состоится #{date} по адресу #{place}",
            "Приглашаем Вас посетить #{event} #{date} по адресу #{place}"]
    text[rand(text.size)]
  end

  def self.create_invitations(notes, event, event_date, place)
    date = DateTime.parse(event_date).strftime('%m/%d/%Y %I:%M')
    invitation = get_text(event, date, place)
    notes.each do |note|
      filepath = File.expand_path("../public/files/#{note[:id]}#{note[:surname]}#{event}.txt", __dir__)
      out_file = File.new(filepath, 'w')
      address = if note[:gender] == 'женский'
                  "Уважаемая #{note[:surname]} #{note[:name]} #{note[:patronymic_name]},"
                else
                  "Уважаемый #{note[:surname]} #{note[:name]} #{note[:patronymic_name]},"
                end
      out_file.puts(address + "\n" + invitation)
      out_file.close
    end
  end

  def self.create_list(notes, file_name)
    return if file_name.empty?

    filepath = File.expand_path("../public/files/#{file_name}.txt", __dir__)
    out_file = File.new(filepath, 'w')
    out_file.puts("Список гостей:\n")
    notes.each do |note|
      out_file.puts("#{note[:surname]} #{note[:name]} #{note[:patronymic_name]}")
    end
    out_file.close
  end
end
