# frozen_string_literal: true

require 'sequel'
require_relative 'note'
require 'date'
# model for a notes datatable
class Note < Sequel::Model(:notes)
  many_to_one :status

  def self.closest_dates(sel_date)
    date = sel_date.yday
    db["SELECT *,
      case when (strftime('%j', birthday_date) - #{date} > 0)
      THEN
      strftime('%j',birthday_date) - #{date}
      ELSE
      strftime('%j',birthday_date) + 365 - #{date}
      END
      as datediff
      FROM notes
      WHERE birthday_date IS NOT NULL
      ORDER BY datediff
      LIMIT 5"].all
  end

  def self.search_by(search, selection)
    case selection
    when 'Фамилии'
      where(Sequel[:surname].like("#{search}%"))
    when 'Имени'
      where(Sequel[:name].like("#{search}%"))
    when 'Статусу'
      where(status_id: Status.where(Sequel[:name].like("#{search}%")).get(:id))
    end
  end

  def self.update_note(person, note_id, new_status_id)
    self[note_id].update(cell_phone_num: person[:cell_phone_num],
                         home_phone_num: person[:home_phone_num],
                         address: person[:address],
                         status_id: new_status_id)
  end
end
