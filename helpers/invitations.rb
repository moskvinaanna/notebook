module Invitations
  def self.create_invitations(notes, event, date, place)
    text = ["Приглашаем вас принять участие в праздновании #{event}, которое состоится #{date} в #{place}",
            "Приглашаем вас посетить #{event} #{date} по адресу #{place}"]
    invitation = text[rand(text.size)]
    notes.each do |note|
      filepath = File.expand_path("../public/#{note[:id]}.txt", __dir__)
      if !File.exist? filepath
        out_file = File.new(filepath, 'w')
      else
        out_file = File.open(filepath, 'w')
      end
      address = if note[:gender] == 'женский'
                  "Уважаемая #{note[:surname]} #{note[:name]} #{note[:patronymic_name]},"
                else
                  "Уважаемый #{note[:surname]} #{note[:name]} #{note[:patronymic_name]},"
                end
      out_file.puts(address + "\n" + invitation)
      out_file.close
    end
  end
end
