require_relative 'person'
class Notes
  def initialize
    @notes = [Person.new({name: "mom", surname: "moskvina", patronymic_name:"alekseevna", cell_phone_num: 2893748, home_phone_num: 1123123, address: "sdasd", birthday_date: "1971", gender: "f", status: "family"})]
  end

  def each(&block)
    @notes.each(&block)
  end

  def note_by_id(note_id)
    @notes[note_id]
  end

  def append(person)
    @notes.append(person)
  end

  def remove(note_id)
    @notes.delete_at(note_id)
  end
end